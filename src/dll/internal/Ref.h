// Copyright © Opera Norway AS. All rights reserved.
// This file is an original work developed by Opera.
#ifndef __REF_H__
#define __REF_H__

#include "YYStd.h"
#include <string.h>
#include <atomic>


#define YYC_DELETE(a) delete a


class YYObjectBase;
template <typename T> struct _RefFactory
{
	static T Alloc( T _thing, int _size )		{ return _thing; }
	static T Create( T _thing, int& _size )		{ _size=0; return _thing; }
	static T Destroy( T _thing )	{ return _thing; }
};

template <> struct _RefFactory< const char* >
{
	static const char* Alloc( const char* _thing, int _size )	{ return (const char*)YYAlloc( _size+1 ); }
	static const char* Create(const char* _thing, int& _size) { _size = _thing ? (int)strlen(_thing) : 0; return YYStrDup(_thing); }
	static const char* Destroy( const char* _thing ) { YYFree( (void*)_thing ); return NULL; }
};

// NOTE: constant strings have negative size
typedef const unsigned char* YYCONSTSTRING;
template <> struct _RefFactory< YYCONSTSTRING >
{
	static YYCONSTSTRING Alloc(YYCONSTSTRING _thing, int _size) { return (YYCONSTSTRING)_thing; }
	static YYCONSTSTRING Create(YYCONSTSTRING _thing, int& _size) { _size = _thing ? (int)(0x80000000L | (int)strlen((const char*)_thing)) : 0; return _thing; }
	static YYCONSTSTRING Destroy(YYCONSTSTRING _thing) { return NULL; }
};


template <> struct _RefFactory< YYObjectBase* >
{
	static YYObjectBase* Alloc( YYObjectBase* _thing, int _size );
	static YYObjectBase* Create( YYObjectBase* _thing, int& _size );
	static YYObjectBase* Destroy( YYObjectBase* _thing );
};

template <> struct _RefFactory< void* >
{
	static void* Alloc( void* _thing, int _size );
	static void* Create( void* _thing, int& _size );
	static void* Destroy( void* _thing );
};


template <typename T > struct _RefThing
{
	T		m_thing;
	std::atomic<int> m_refCount;
	int		m_size;

	_RefThing( T _thing )
	{
		// this needs to have some sort of factory based on the type to do a duplicate
		m_thing = _RefFactory<T>::Create(_thing, m_size);
		m_refCount = 0;
		inc();
	} // end _RefThing

	_RefThing( int _maxSize )
	{
		// this needs to have some sort of factory based on the type to do a duplicate
		m_thing = _RefFactory<T>::Alloc(m_thing, _maxSize );
		m_size = _maxSize;
		m_refCount = 0;
		inc();
	} // end _RefThing

	_RefThing( const _RefThing<T>& _other )
	{
		// preserves the old implicit memberwise-copy behaviour (still just a raw m_thing copy,
		// not a real duplicate/inc of the source) now that std::atomic makes that copy no longer implicit
		m_thing = _other.m_thing;
		m_refCount.store( _other.m_refCount.load( std::memory_order_relaxed ), std::memory_order_relaxed );
		m_size = _other.m_size;
	} // end _RefThing (copy)

	~_RefThing()
	{
		dec();
	} // end ~_RefThing

	void inc( void ) {
		// relaxed: caller already holds a valid reference, so there's nothing else to synchronize-with here
		m_refCount.fetch_add(1, std::memory_order_relaxed);
	} // end Inc

	void dec( void ) {
		// acq_rel: release pairs with other threads' decrements so the one that observes the count
		// reach zero has a synchronized view of all writes made through other references before they let go
		if (m_refCount.fetch_sub(1, std::memory_order_acq_rel) == 1) {
			// use the factory to clean it up and give us a default thing to use
			m_thing = (m_size >= 0) ? _RefFactory<T>::Destroy(m_thing) : NULL;
			m_size = 0;

			YYC_DELETE(this);
		} // end if
	} // end Dec

	T get( void ) const { return m_thing; }
	int size( void ) const { return m_size&0x7fffffff; } // should only ever be positive

	static _RefThing<T>* assign( _RefThing<T>* _other ) { if (_other != NULL) { _other->inc(); } return _other; }
	static _RefThing<T>* remove( _RefThing<T>* _other ) { if (_other != NULL) { _other->dec(); } return NULL; }
};

template <typename T> struct RefThing
{
	_RefThing<T>*	m_pThing;

	RefThing() { m_pThing = NULL; }

	RefThing( T _thing )
	{
		m_pThing = new _RefThing<T>( _thing );
	} // end RefThing

	RefThing( const _RefThing<T>& _other ) 
	{
		m_pThing = _other.m_pThing;
		m_pThing->Inc();
	} // end RefThing

	~RefThing()
	{
		if (m_pThing != NULL) {
			m_pThing->Dec();
		} // end if
	} // end RefThing

	void dec( void ) {
		if (m_pThing != NULL) {
			m_pThing->Dec();
		} //  end if
		m_pThing = NULL;
	} // end dec

	T get( void ) const { 
		return (m_pThing != NULL) ? m_pThing->m_thing : NULL; 
	} // end get
};

typedef _RefThing<const char*> RefString;
typedef _RefThing<YYCONSTSTRING> RefConstString;
typedef _RefThing<YYObjectBase*> RefInstance;
typedef _RefThing<void*> RefKeep;

class CInstance;
typedef RValue& (*PFUNC_YYGMLScript_Internal)( CInstance* pSelf, CInstance* pOther, RValue& _result, int _count,  RValue** _args  );

YYCEXTERN void YYCreateString( RValue* _pVal, RefString* _pS );
YYCEXTERN void YYSetInstance( RValue* _pVal );
YYCEXTERN void YYSetScriptRef( RValue* _pVal );
YYCEXTERN void YYSetScriptRef( RValue* _pVal, PFUNC_YYGMLScript_Internal _pScript, YYObjectBase* _pSelf);
YYCEXTERN void YYSetString( RValue* _pVal, RefString* _pS );

#endif

