<%--
  Created by IntelliJ IDEA.
  User: junypooh
  Date: 2018-01-17
  Time: 오후 1:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div>
    <form:form id="fileForm"  method="post" enctype="multipart/form-data">
        첨부파일<br/>
        <input type="file" name="uploadFile" id="uploadFile" value="찾아보기" />
        <input type="hidden" name="type" value="BANNER" />
    </form:form>
</div>

<script type="text/javascript">
    /* 첨부파일 추가 */
    $('#uploadFile').change(function(){
        $("#fileForm").ajaxForm({
            url : "${pageContext.request.contextPath}/file/upload",
            dataType: 'text',
            success:function(data, status){
                var response = JSON.parse(data);
                console.log(response.fileSeq);
            }
        }).submit();

    });
</script>
