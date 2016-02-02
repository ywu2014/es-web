/**
 * 提供统一格式的操作提醒
 * @param data
 */
function responseTips(data) {
	if (data) {
		toastr.options = {
			"closeButton": true,
			"debug": true,
			"progressBar": true,
			"positionClass": "toast-top-center",
			"showDuration": "400",
			"hideDuration": "1000",
			"timeOut": "4000",
			"extendedTimeOut": "1000",
			"showEasing": "swing",
			"hideEasing": "linear",
			"showMethod": "fadeIn",
			"hideMethod": "fadeOut"
		};
		if (data.status) {
			toastr.success(data.msg, "操作提示!");
		} else {
			toastr.error(data.msg, "操作提示!");
		}
	}
}