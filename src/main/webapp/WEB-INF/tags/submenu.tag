<%@tag pageEncoding="UTF-8" description="构建子菜单" %>
<%@ attribute name="menu" type="com.jiangnan.es.authorization.resource.entity.Resource" required="true" description="当前菜单" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="es" tagdir="/WEB-INF/tags" %>

<c:choose>
    <c:when test="${!menu.hasChildren}">
    	<a href="${ctx }${menu.url }" class="J_menuItem"><i class="fa ${menu.icon }"></i><span class="nav-label">${menu.name }</span></a>
    </c:when>
    <c:otherwise>
        <li>
            <a href="#"><i class="fa ${menu.icon }"></i><span class="nav-label">${menu.name }</span><span class="fa arrow"></span></a>
            <ul class="nav nav-third-level">
            	<c:forEach items="${menu.children }" var="c">
               		<li>
               			<es:submenu menu="${c }"></es:submenu>
               		</li>
               	</c:forEach>
            </ul>
        </li>
    </c:otherwise>
</c:choose>