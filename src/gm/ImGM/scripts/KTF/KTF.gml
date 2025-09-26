/// Ken's Test Framework
//
//  @author knno
//
// A minimal single-script framework for running tests
// Triggered when Config is "Test"
//
// - Just add the `obj_ktf_stepper` in the first room..
// - gitignore the `ktf-stats.log`
// - stats log is updated in real-time, for github workflows.
//
///

/// @desc Find the KTF tests...
function __GetKTFData() {
    return [
        {
            name: "foo",
            func: ktf_test_foo,
        },
        {
            name: "bar",
            func: ktf_test_bar,
        },
        {
            name: "baz",
            func: ktf_test_baz,
        },

    ]
}

#region Test funcs

function ktf_test_foo() {
    if not test.is_testing {
        var fixtures = [
			new __KTFFixture("fixture01", function(){ /*show_debug_message("KTF: Fixture01 setup!")*/ }, function(){ /*show_debug_message("KTF: Fixture01 cleanup!")*/ }),
        ];
        return {fixtures};
    }

    test.AssertEqual("hi", "hi");
    test.Done();
}

function ktf_test_bar() {
    if not test.is_testing {
        var fixtures = [
            new __KTFFixture("fixture02", function(){ /*show_debug_message("KTF: Fixture02 setup!")*/ }, function(){ /*show_debug_message("KTF: Fixture02 cleanup!")*/ }),
        ];
        return {fixtures};
    }

    test.AssertEqual("hi", "hi");
    test.AssertEqual("hi", "hi");
    test.Done();
}

function ktf_test_baz() {
    if not test.is_testing {
        test.foo1baz = 0;
        test.step_func = test.func;
        return {fixtures: ["fixture02"]};
    }

    if test.foo1baz > 100 {
        test.Done();
    } else {
        test.foo1baz ++;
        if test.foo1baz mod 10 == 1{
            test.AssertEqual(true, true);
        }
    }
}

#endregion

#region KTF Internal

function __KTF() constructor {

    /// Classes
    static Test = __KTFTest
    static Fixture = __KTFFixture
    static AssertionError = __KTFAssertionError
    static TestManager = __KTFManager

    /// Attrs
    static enabled = os_get_config() == "Test";
	static __started = false;
	static fixtures = [] // Default fixtures
    static __out_json = {
        success: 0,
        failed: 0,
        count: 0,
        status:  enabled ? "pending" : "disabled",
        stats: {
            started_at: date_datetime_string(date_current_datetime()),
        },
        tests: {},
    }
	static test_manager = new __KTFManager()

    /// Funcs
	static __Step = function() {
        if (__KTF.enabled) {
    		if (not __KTF.__started) {
    			__KTF.__started = true;
    		    __KTF.test_manager.FindTests();
                __KTF.test_manager.UpdateOutJson()
    			__KTF.test_manager.Test();
    		}
    		if (__KTF.test_manager != undefined) {
    			if (__KTF.test_manager.step_enabled) {
    					__KTF.test_manager.Step();
    			}
    		}
        } else {
            __KTF.__out_json.status = "disabled";
        }
	}
}

function __KTFAssertionError(error, message=undefined, longMessage=undefined) constructor {
    self.error = error;
    self.message = message ?? (is_string(error) ? error : error.message);
    self.longMessage = longMessage ?? (is_string(error) ? error : error.longMessage);
}
/// @desc A singleton that is created if `is_testing` is `true`. It finds tests and does them one by one.
function __KTFManager() constructor {
	var this = self;

    self._console_tag = "KTF: ";
    self.testing_tests = [];
    // self.available_tests = tests;

    static reports = undefined;
    self.step_enabled = true;

    static FindTests = function() {
        var fs = {};
        var founds = __GetKTFData();
        var scr;
        for (var i=0; i<array_length(founds); i++) {
            fs[$ founds[i].name] = new __KTFTest(
                founds[i].name, founds[i][$ "fixtures"], founds[i].func, founds[i][$ "step_func"]
            );
        }
        __KTF.__out_json.count = array_length(founds);
        self.available_tests = fs;
        return fs;
    }

    static UpdateOutJson = function() {
        var json = json_stringify(__KTF.__out_json);
        var f = file_text_open_write("ktf-stats.log");
        file_text_write_string(f, json);
        file_text_close(f);
    }

    static Test = function() {
        var _tests = [];
        var _test_names = struct_get_names(self.available_tests);
        array_sort(_test_names, true);

        for (var i = 0; i < array_length(_test_names); i++) {
            var name = _test_names[i];
            var test = self.available_tests[$ name];
            __KTF.__out_json.tests[$ test.name] = {
                status: "pending",
                success: undefined,
            }
            UpdateOutJson();

            test.Test(); // Run synchronously
            show_debug_message("[KTF] testing \"" + test.name + "\"...");
            self.Step();
        }
    }

    Step = method({this}, function() {
        var test, status, report, _f = false;
        for (var i=0; i<array_length(this.testing_tests); i++) {
            test = this.testing_tests[i];
            report = __KTF.__out_json.tests[$ test.name];
            status = method({this: test}, test.Proceed)();
            if status == 2 {
                if variable_struct_exists(test.result, "assertions") {report.assertions = test.result.assertions;};
                if variable_struct_exists(test.result, "success") {report.success = test.result.success;};
                if variable_struct_exists(test.result, "error") {report.error = test.result.error;};
                if variable_struct_exists(test.result, "output") {report.output = test.result.output;};
                if report.success {
                    __KTF.__out_json.success ++;
                    report.status = "success";
                } else {
                    __KTF.__out_json.failed ++;
                    report.status = "failed";
                }
            } else {
                report.status = "running";
            }
        }
        if (__KTF.__out_json.success + __KTF.__out_json.failed) == (__KTF.__out_json.count) {
            this.step_enabled = false;
            __KTF.__out_json.status = "done";
            __KTF.__out_json.stats.completed_at = date_datetime_string(date_current_datetime());
            this.UpdateOutJson();
            show_debug_message($"{__KTF.__out_json.success}/{__KTF.__out_json.count} Tests passed" + (__KTF.__out_json.failed == 0 ? " ✔️" : " ✖️"));
            game_end();
        }
    });
}

function __KTFTest(name, fixtures, func, step_func=undefined) constructor {
    var this = self;
    self.name = name;
    self.fixtures = fixtures ?? [];
    self.is_testing = false;
    ResolveFixtures = method({this}, function() {
        var _resolved_fixtures = [];
        array_foreach(this.fixtures, method({this, _resolved_fixtures}, function(_element, _index) {
            if !is_instanceof(_element, __KTFFixture) {
                var _ind = array_find_index(__KTF.fixtures, method({_element}, function(_element2, _index2) {
                    if is_string(_element) {
                        return _element2.name == _element;
                    } else if is_struct(_element) {
                        return _element2.name == _element.name;
                    }
                }));
                if _ind > -1 {
                    _resolved_fixtures[array_length(_resolved_fixtures)] = __KTF.fixtures[_ind];
                } else {
                    var fixname = _element;
                    var broken = true;
                    var new_fixture;
                    if is_struct(_element) {
                        try {
                            fixname = _element.name;
                            new_fixture = new __KTFFixture(fixname, _element.func_setup, _element.func_cleanup);
                            broken = false;
                        } catch (e) {
                            //
                        }
                    }
                    if broken {
                        throw new __KTFAssertionError($"Test \"{this.name}\" fixture \"{fixname}\" does not exist.");
                    } else {
                        _resolved_fixtures[array_length(_resolved_fixtures)] = new_fixture;
                    }
                }
            } else {
                _resolved_fixtures[array_length(_resolved_fixtures)] = _element;
            }
        }));
        this.fixtures = _resolved_fixtures;
        return this.fixtures;
    });
    self.Test = function() {
        var this = self;

        self.result = {
            // test: this,
            assertions: 0,
            success: undefined,
            error: undefined,
            output: undefined,
        };

		try {self.fixtures = self.ResolveFixtures();}
        catch (error) {
            self.Fail(error);
            return; // Nothing done.
        }

        for (var i=0; i<array_length(self.fixtures); i++) {
            self.fixtures[i].Setup({
                test: this,
				test_manager: __KTF.test_manager,
            });
        }
        try {
            self.is_testing = true;
            array_push(__KTF.test_manager.testing_tests, this);

            method({test_manager: __KTF.test_manager, test: this}, this.func)();
            return true;

        } catch (error) {
            self.Fail(error);
        }
	}
    self.Proceed = method({this}, function() {

        if this.step_func != undefined {
			method({test_manager: __KTF.test_manager, test: this}, this.step_func)();
        }
        if this.result.error != undefined {
            this.result.success = false;
        }

        if this.result.success != undefined {
            this.Finish();
            return 2;
        }
	});
    self.Finish = method({this}, function() {
        for (var i=0; i<array_length(this.fixtures); i++) {
            this.fixtures[i].Cleanup({
                test: this,
            });
        }

        array_delete(__KTF.test_manager.testing_tests, array_get_index(__KTF.test_manager.testing_tests, this), 1);
        this.is_testing = false;
        return true;
    });
    self.Fail = method({this}, function(error) {
        this.result.success = false;
        this.result.error = error;
    });
    self.Done = method({this}, function(output) {
        this.result.success = true;
        this.result.output = output;
    });
    self.AssertEqual = method({this}, function(val1, val2) {
        if val1 == val2 {
            this.result.assertions++;
        } else {
            this.Fail($"Test \"{this.name}\" AssertionError: {val1} is not {val2}");
        }
    });


	self.func = func;
	if self.func != undefined {
        self.func = method({test: this}, self.func);
		var n = script_get_name(self.func);
        r = true;
    }

    self.step_func = step_func;
    if self.step_func != undefined {
        if self.step_func == "func" {
            self.step_func = self.func;
        }
        self.step_func = method({test: this}, self.step_func);
    }

    if r {
        // Run once initiated to get the fixture set.
        self.is_testing = false;
        r = method({test: this}, self.func)();
        if is_struct(r) {
            self.name = variable_struct_exists(r, "name") ? variable_struct_get(r, "name") : self.name;
            self.fixtures = variable_struct_exists(r, "fixtures") ? variable_struct_get(r, "fixtures") : self.fixtures;
            self.func = variable_struct_exists(r, "func") ? method({test: this}, variable_struct_get(r, "func")) : self.func;
            self.step_func = variable_struct_exists(r, "step_func") ? method({test: this}, variable_struct_get(r, "step_func")) : self.step_func;
        } else {
            throw $"Test \"{self.name}\" function did not return a struct.";
        }
    }
}

function __KTFFixture(name, _func_setup, _func_cleanup) constructor {
    self.name = name;

    var _fixtures = __KTF.fixtures;
    for (var i=0; i<array_length(_fixtures); i++) {
        if _fixtures[i].name == name {
            throw $"Fixture \"{name}\" already defined.";
        }
    }

    self._testing_tests = [];
    self.func_setup = _func_setup;
    self.func_cleanup = _func_cleanup;
    self.is_applied = false;

    static Setup = function(args=undefined) {
        if not self.is_applied {
            method({test_manager: __KTF.test_manager}, self.func_setup)();
            self.is_applied = true;
            array_push(self._testing_tests, args.test);
        }
    };

    static Cleanup = function(args=undefined) {
        var this = self;
        if self.is_applied {
            array_delete(self._testing_tests, array_get_index(self._testing_tests, args.test), 1);
            if array_length(self._testing_tests) == 0 {
                var _found = false;
                var fixt;
                for (var _i=0;_i<array_length(__KTF.test_manager.testing_tests);_i++) {
                    var _ind = array_find_index(__KTF.test_manager.testing_tests[_i].fixtures, method({fixt: this}, function(ele,ind) {
                        if is_string(ele) {
                            return ele == fixt.name;
                        } else if is_struct(ele) {
                            return ele.name == fixt.name;
                        }
                    }));
                    if (_ind > -1) _found = true;
                    if (_found) {
                        break;
                    }
                }
                if (_found) {
    	            method({test_manager: __KTF.test_manager}, self.func_cleanup)();
                    self.is_applied = false;
                }
            }
        }
    };

    _fixtures = __KTF.fixtures; _fixtures[array_length(_fixtures)] = self;
}

#endregion

global.ktf = new __KTF();
