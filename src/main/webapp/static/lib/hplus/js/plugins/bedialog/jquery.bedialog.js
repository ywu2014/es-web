/*
* 基于bootstrap modal的扩展对话框
*/
(function($) {
	$.fn.bedialog = function(options) {
		var target = this;
		if (options.url) {
			$.get(options.url, {}, function(data) {
				target.html(data);
			});
		}
		this.modal(options);
	}
})(jQuery)