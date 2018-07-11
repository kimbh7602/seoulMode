<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
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
</body>
</html>
