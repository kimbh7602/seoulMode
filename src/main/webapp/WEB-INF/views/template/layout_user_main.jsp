<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<tiles:insertAttribute name="layout.header" />
<title><tiles:getAsString name="layout.title" /></title>

</head>
<body class="nav-md">
    <div class="container body">
      <div class="main_container">
			<tiles:insertAttribute name="layout.left" />
			<tiles:insertAttribute name="layout.top" />
		<tiles:insertAttribute name="layout.body" />
    <tiles:insertAttribute name="layout.footer"/>
     </div>
    </div>
    

   	<!-- jQuery -->
    <script src="<c:url value = '/resources/js/jquery.min.js'/>"></script>
    <!-- Bootstrap -->
    <script src="<c:url value = '/resources/js/bootstrap.min.js'/>"></script>
    <!-- FastClick -->
    <script src="<c:url value = '/resources/js/fastclick.js'/>"></script>
    <!-- NProgress -->
    <script src="<c:url value = '/resources/js/nprogress.js'/>"></script>
    <!-- Chart.js -->
    <script src="<c:url value = '/resources/js/Chart.min.js'/>"></script>
    <!-- gauge.js -->
    <script src="<c:url value = '/resources/js/gauge.min.js'/>"></script>
    <!-- bootstrap-progressbar -->
    <script src="<c:url value = '/resources/js/bootstrap-progressbar.min.js'/>"></script>
    <!-- iCheck -->
    <script src="<c:url value = '/resources/js/icheck.min.js'/>"></script>
    <!-- Skycons -->
    <script src="<c:url value = '/resources/js/skycons.js'/>"></script>
    <!-- Flot -->
    <script src="<c:url value = '/resources/js/jquery.flot.js'/>"></script>
    <script src="<c:url value = '/resources/js/jquery.flot.pie.js'/>"></script>
    <script src="<c:url value = '/resources/js/jquery.flot.time.js'/>"></script>
    <script src="<c:url value = '/resources/js/jquery.flot.stack.js'/>"></script>
    <script src="<c:url value = '/resources/js/jquery.flot.resize.js'/>"></script>
    <!-- Flot plugins -->
    <script src="<c:url value = '/resources/js/jquery.flot.orderBars.js'/>"></script>
    <script src="<c:url value = '/resources/js/jquery.flot.spline.min.js'/>"></script>
    <script src="<c:url value = '/resources/js/curvedLines.js'/>"></script>
    
    <!-- DateJS -->
    <script src="<c:url value = '/resources/js/date.js'/>"></script>
    
    <!-- JQVMap -->
    <script src="<c:url value = '/resources/js/jquery.vmap.js'/>"></script>
    <script src="<c:url value = '/resources/js/jquery.vmap.world.js'/>"></script>
    <script src="<c:url value = '/resources/js/jquery.vmap.sampledata.js'/>"></script>
    <!-- bootstrap-daterangepicker -->
    <script src="<c:url value = '/resources/js/moment.min.js'/>"></script>
    <script src="<c:url value = '/resources/js/daterangepicker.js'/>"></script>
    
    <!-- bootstrap-wysiwyg -->
    <script src="<c:url value = '/resources/js/bootstrap-wysiwyg.min.js'/>"></script>
    <script src="<c:url value = '/resources/js/jquery.hotkeys.js'/>"></script>
    <script src="<c:url value = '/resources/js/prettify.js'/>"></script>
    <!-- jQuery Tags Input -->
    <script src="<c:url value = '/resources/js/jquery.tagsinput.js'/>"></script>
    <!-- Switchery -->
    <script src="<c:url value = '/resources/js/switchery.min.js'/>"></script>
    <!-- Select2 -->
    <script src="<c:url value = '/resources/js/select2.full.min.js'/>"></script>
    <!-- Parsley -->
    <script src="<c:url value = '/resources/js/parsley.min.js'/>"></script>
    <!-- Autosize -->
    <script src="<c:url value = '/resources/js/autosize.min.js'/>"></script>
    <!-- jQuery autocomplete -->
    <script src="<c:url value = '/resources/js/jquery.autocomplete.min.js'/>"></script>
    <!-- starrr -->
    <script src="<c:url value = '/resources/js/starrr.js'/>"></script>
    
    
    <!-- Datatables -->
    <script src="<c:url value = '/resources/js/jquery.dataTables.min.js'/>"></script>
    <script src="<c:url value = '/resources/js/dataTables.bootstrap.min.js'/>"></script>
    <script src="<c:url value = '/resources/js/dataTables.buttons.min.js'/>"></script>
    <script src="<c:url value = '/resources/js/buttons.bootstrap.min.js'/>"></script>
    <script src="<c:url value = '/resources/js/buttons.flash.min.js'/>"></script>
    <script src="<c:url value = '/resources/js/buttons.html5.min.js'/>"></script>
    <script src="<c:url value = '/resources/js/buttons.print.min.js'/>"></script>
    <script src="<c:url value = '/resources/js/dataTables.fixedHeader.min.js'/>"></script>
    <script src="<c:url value = '/resources/js/dataTables.keyTable.min.js'/>"></script>
    <script src="<c:url value = '/resources/js/dataTables.responsive.min.js'/>"></script>
    <script src="<c:url value = '/resources/js/responsive.bootstrap.js'/>"></script>
    <script src="<c:url value = '/resources/js/dataTables.scroller.min.js'/>"></script>
    <script src="<c:url value = '/resources/js/jszip.min.js'/>"></script>
    <script src="<c:url value = '/resources/js/pdfmake.min.js'/>"></script>
    <script src="<c:url value = '/resources/js/vfs_fonts.js'/>"></script>

    <!-- Custom Theme Scripts -->
    <script src="<c:url value = '/resources/js/custom.min.js'/>"></script>
    
    <!-- jqplot -->
    <script src="<c:url value = '/resources/js/excanvas.js'/>"></script>
    <script src="<c:url value = '/resources/js/excanvas.min.js'/>"></script>
    <script src="<c:url value = '/resources/js/jquery.jqplot.js'/>"></script>
    <script src="<c:url value = '/resources/js/jquery.jqplot.min.js'/>"></script>
    <script src="<c:url value = '/resources/js/jqplot.barRenderer.js'/>"></script>
    <script src="<c:url value = '/resources/js/jqplot.barRenderer.min.js'/>"></script>
    <script src="<c:url value = '/resources/js/jqplot.pieRenderer.js'/>"></script>
    <script src="<c:url value = '/resources/js/jqplot.pieRenderer.min.js'/>"></script>
    
    
    
</body>
</html>
