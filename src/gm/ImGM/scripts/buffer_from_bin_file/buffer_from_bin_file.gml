/**
 * @desc Reads a binary file into a buffer
 * @param {String} filepath path to the file to read from as binary
 * @param {Constant.BufferDataType} [datatype=buffer_u8] the data type to write the buffer (default is buffer_u8)
 * @return {Id.Buffer}
 *
 */
function buffer_from_bin_file(filepath, datatype = buffer_u8) {
	var fh = file_bin_open(filepath, 0);
	var buf_size  = file_bin_size(fh);
	var data= buffer_create(buf_size, buffer_fixed, 1);
	buffer_seek(data, buffer_seek_start, 0);
	for (var i = 0; i < buf_size; i++) {
	    var b = file_bin_read_byte(fh);
	    buffer_write(data, datatype, b);
	}
	file_bin_close(fh);
	return data
}