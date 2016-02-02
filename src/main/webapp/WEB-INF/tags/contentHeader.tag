<%@tag pageEncoding="utf-8"%>
<%@attribute name="title" description="html title" type="java.lang.String" required="false"%>
<meta charset="utf-8" />
<title>${title }</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- basic styles -->
<link href="${webBase }/static/lib/ace/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="${webBase }/static/lib/ace/css/font-awesome.min.css" />

<!--[if IE 7]>
  <link rel="stylesheet" href="${webBase }/static/lib/ace/css/font-awesome-ie7.min.css" />
<![endif]-->

<!-- page specific plugin styles -->
<!-- 以下是每个页面特定的样式 -->
<link rel="stylesheet" href="${webBase }/static/lib/ace/css/jquery-ui-1.10.3.full.min.css" />
<link rel="stylesheet" href="${webBase }/static/lib/ace/css/datepicker.css" />
<link rel="stylesheet" href="${webBase }/static/lib/ace/css/ui.jqgrid.css" />

<!-- fonts -->

<link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300" />

<!-- ace styles -->

<link rel="stylesheet" href="${webBase }/static/lib/ace/css/ace.min.css" />
<link rel="stylesheet" href="${webBase }/static/lib/ace/css/ace-rtl.min.css" />
<link rel="stylesheet" href="${webBase }/static/lib/ace/css/ace-skins.min.css" />

<!--[if lte IE 8]>
  <link rel="stylesheet" href="${webBase }/static/lib/ace/css/ace-ie.min.css" />
<![endif]-->

<!-- inline styles related to this page -->

<!-- ace settings handler -->

<script src="${webBase }/static/lib/ace/js/ace-extra.min.js"></script>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

<!--[if lt IE 9]>
<script src="${webBase }/static/lib/ace/js/html5shiv.js"></script>
<script src="${webBase }/static/lib/ace/js/respond.min.js"></script>
<![endif]-->