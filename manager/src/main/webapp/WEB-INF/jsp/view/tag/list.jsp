<%--
    태그관리/목록
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div id="body">
    <div id="container" class="container">
        <div class="wrap-contents">
    		<div class="page-control">
    			<div class="row">
    				<div class="col-xs-6">
    					<span class="page-title"> 태그 관리 </span>
    				</div>
    				<div class="col-xs-6 text-right" id="head">
    				    <c:if test="${searchParam.expsYn != 'Y'}">
    					    <button type="button" class="btn btn-default" id="save">정렬 저장</button>
    					</c:if>
    					<button type="button" class="btn btn-primary" id="check">등록</button>
    				</div>
                    <input type="hidden" value="100.5" name="addflag">
    			</div>
    		</div>
    		<div class="contents">
    		    <div class="card">
    				<div class="tools">
    					<div class="row">
    					    <form id="expsForm">
    							<div class="col-xs-4">
    								<span class="checkbox">
    									<label>
    										<input type="checkbox" name="expsYn" id="expsYn" value="Y" <c:if test="${searchParam.expsYn == 'Y'}">checked="checked"</c:if>> 노출
    									</label>
    								</span>
    							</div>
    						</form>
    					</div>
    				</div>

                    <form id="tagForm" onsubmit="return false;">
                        <table id="tt" class="table table-hover table-bordered table-vertical main-options">
                            <colgroup>
                                <col style="width: 70px;">
                                <col>
                                <col style="width: 100px;">
                                <col style="width: 160px;">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>정렬</th>
                                    <th>태그명</th>
                                    <th>노출 여부</th>
                                    <th>관리</th>
                                </tr>
                            </thead>
                            <tbody>
                                    <c:forEach items="${list}" var="item" varStatus="status">
                                        <tr id="t${status.index}">
                                        <td>
                                            <button type="button" name="up" class="btn btn-xs btn-default" <c:if test="${status.first || searchParam.expsYn eq 'Y'}">disabled="disabled"</c:if>><i class="fa fa-arrow-up"></i></button>
                                            <button type="button" name="down" class="btn btn-xs btn-default" <c:if test="${status.last || searchParam.expsYn eq 'Y'}">disabled="disabled"</c:if>><i class="fa fa-arrow-down"></i></button>
                                        </td>
                                        <td class="text-left">
                                            <input name="ordNo" type="hidden" value="${item.ordNo}">
                                            <input name="tagSeq" type="hidden" value="${item.tagSeq}">
                                            <input name="index" type="hidden" value="${status.index}">
                                            <div name="tagName"><c:out value="${item.tagNm}"/></div><input name="tagName" style="display : none;" type="text" class="form-control" placeholder="태그명을 입력하세요." value="${item.tagNm}">
                                        </td>
                                        <td>
                                            <div class="onoffswitch">
                                                <input name="expvalue" type="hidden" value="${item.expsYn}">
                                                    <c:if test="${item.expsYn eq 'Y'}">
                                                        <input type="checkbox" class="onoffswitch-checkbox" data-id="${item.tagSeq}" name="isVisibled" id="isVisibled-${item.tagSeq}"  disabled="disabled" checked="checked">
                                                    </c:if>
                                                    <c:if test="${item.expsYn eq 'N'}">
                                                        <input type="checkbox" class="onoffswitch-checkbox" data-id="${item.tagSeq}" name="isVisibled" id="isVisibled-${item.tagSeq}" disabled="disabled" >
                                                    </c:if>
                                                <label class="onoffswitch-label" for="isVisibled-${item.tagSeq}">
                                                    <i class="inner"></i><i class="switch"></i>
                                                </label>
                                            </div>
                                        </td>
                                        <td>
                                            <button name="editButton"  type="button" class="btn btn-xs btn-default">편집</button>
                                            <button name="editUpdateButton" type="button" style="display : none;" class="btn btn-xs btn-primary">저장</button>
                                            <button name="editCancelButton" type="button" style="display : none;" class="btn btn-xs btn-default" >취소</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </form>
    				<div id="count" class="row">
    					<div class="col-xs-2">
    						Total : <span>${fn:length(list)}</span>
    					</div>
    				</div>
    			</div>
    		</div>
    	</div>
    </div>
</div>

<script type="text/javascript">
//등록 눌렀을시
$(document).on("click","#check",function(){
    var addflag=$("input[name='addflag']").val();
    var str='';
    str+='<tr>';
    str+='   <td>';
    str+='       <button type="button" class="btn btn-xs btn-default"><i class="fa fa-arrow-up"></i></button>';
    str+='       <button type="button" class="btn btn-xs btn-default"><i class="fa fa-arrow-down"></i></button>';
    str+='   </td>';
    str+='   <td>';
    str+='       <input name="tagName" type="text" class="form-control" placeholder="태그명을 입력하세요.">';
    str+='   </td>';
    str+='   <td>';
    str+='       <div class="onoffswitch">';
    str+='           <input type="checkbox" class="onoffswitch-checkbox" data-id="'+addflag+'" name="isVisibledadd" id="isVisibled-'+addflag+'" checked="checked">';
    str+='               <label class="onoffswitch-label" for="isVisibled-'+addflag+'">';
    str+='                   <i class="inner"></i><i class="switch"></i>';
    str+='               </label>';
    str+='       </div>';
    str+='   </td>';
    str+='   <td>';
    str+='       <button type="button" name="editButton"  class="btn btn-xs btn-default" style="display: none;">편집</button>';
    str+='       <button type="button" name="UpdateButton" class="btn btn-xs btn-primary">저장</button>';
    str+='       <button type="button" name="CancelButton" class="btn btn-xs btn-default" >취소</button>';
    str+='   </td>';
    str+='</tr>';
    $("#tt").append(str);
    $("input[name='addflag']").val((Number(addflag)+1));
});

//등록에서의 취소버튼 이벤트
$(document).on("click","button[name='CancelButton']",function(){
    var tr = $(this).closest("tr");
    $(tr).empty();
});

//등록에서의 적용버튼 이벤트
$(document).on("click","button[name='UpdateButton']",function(){
    var tr = $(this).closest("tr");
    var tagMng = new Object();
    var name=$(tr).find("input[name='tagName']").val();
    if(name==""){
        alert("값이 비었습니다.");
        return;
    }
    tagMng.tagNm=$(tr).find("input[name='tagName']").val();

    if( $(tr).find("input[name='isVisibledadd']").prop('checked')){
        tagMng.expsYn='Y';
    } else {
        tagMng.expsYn='N';
    }

    tagMng.tagSeq=0;
    $.ajax({
        url : "${pageContext.request.contextPath }/tag/registeTagMng",
        type: "POST",
        data : tagMng,
        success : function(result){
            if(result == 1 ){
                expsFormBtn();
            } else {
                alert("수정에 실패했습니다.");
            }
        }
    });
});

//노출버튼 이벤트
$(document).on("click","#expsYn",function(){
    expsFormBtn();
});

//검색버튼
function expsFormBtn(){
    $.ajax({
       url : "${pageContext.request.contextPath}/tag/list",
       type: "POST",
       data : $("#expsForm").serialize(),
       dataType : "html",
       success : function(data){
           var t = $(data).find('#tt').html();
           var c = $(data).find('#count').html();
           var h = $(data).find('#head').html();
           $("#tt").html(t);
           $("#count").html(c);
           $('#head').html(h);
       }
   });
}

//편집버튼 이벤트
$(document).on("click","button[name='editButton']",function(){
    var tr = $(this).closest("tr");
    $(tr).find("div[name='tagName']").hide();
    $(tr).find("input[name='tagName']").show();
    $(tr).find("div[name='isVisibled']").show();
    $(tr).find("button[name='editButton']").hide();
    $(tr).find("button[name='editCancelButton']").show();
    $(tr).find("button[name='editUpdateButton']").show();
    $(tr).find("input[name='isVisibled']").prop("disabled", false);
});

//편집취소버튼 이벤트
$(document).on("click","button[name='editCancelButton']",function(){
    var tr = $(this).closest("tr");
    var exp=$(tr).find("input[name='expvalue']").val();
    $(tr).find("div[name='tagName']").show();
    $(tr).find("input[name='tagName']").hide();
    $(tr).find("button[name='editButton']").show();
    $(tr).find("button[name='editCancelButton']").hide();
    $(tr).find("button[name='editUpdateButton']").hide();

    if(exp=='Y'){
        $(tr).find("input[name='isVisibled']").prop("checked",true);
    } else {
        $(tr).find("input[name='isVisibled']").prop("checked",false);
    }

    $(tr).find("input[name='isVisibled']").prop("disabled", true);
});


//편집적용버튼 이벤트
$(document).on("click","button[name='editUpdateButton']",function(){
    var tr = $(this).closest("tr");
    var tagMng = new Object();
    tagMng.tagNm=$(tr).find("input[name='tagName']").val();
    tagMng.tagSeq=$(tr).find("input[name='tagSeq']").val();

    if( $(tr).find("input[name='isVisibled']").prop('checked')){
        tagMng.expsYn='Y';
    } else {
        tagMng.expsYn='N';
    }

    $.ajax({
         url : "${pageContext.request.contextPath }/tag/updateTagMng",
        type: "POST",
        data : tagMng,
        success : function(result){
            if(result == 1 ){

            } else {
                alert("수정에 실패했습니다.");
            }
        }
    });
    $(tr).find("div[name='tagName']").text($(tr).find("input[name='tagName']").val());
    $(tr).find("div[name='tagName']").show();
    $(tr).find("input[name='tagName']").hide();
    $(tr).find("button[name='editCancelButton']").hide();
    $(tr).find("button[name='editUpdateButton']").hide();
    $(tr).find("button[name='editButton']").show();
    $(tr).find("input[name='isVisibled']").prop("disabled", true);

    if( $(tr).find("input[name='isVisibled']").prop('checked')){
        $(tr).find("input[name='expvalue']").val('Y');
    } else {
        $(tr).find("input[name='expvalue']").val('N');
    }

});


//순서정렬 아래버튼
$(document).on("click","button[name='down']",function(){
    var tr = $(this).closest("tr");

    var index=$(tr).find("input[name='index']").val();
    var seq=$(tr).find("input[name='tagSeq']").val();

    var trr=$("#t"+index);
    var taa=$("#t"+(Number(index)+1));

    var temp1=$(trr).find("input[name='tagName']").val();
    var temp2=$(taa).find("input[name='tagName']").val();
    var temp7=$(trr).find("input[name='tagSeq']").val();
    var temp8=$(taa).find("input[name='tagSeq']").val();

    if( $(trr).find("input[name='isVisibled']").prop("checked")){
        temp3='Y';
    } else {
        temp3='N';
    }

    if( $(taa).find("input[name='isVisibled']").prop("checked")){
        temp4='Y';
    } else {
        temp4='N';
    }

    var temp5=$(trr).find("button[name='editButton']").is(":visible");
    var temp6=$(taa).find("button[name='editButton']").is(":visible");

    if(temp2 != null){
        $(trr).find("input[name='tagName']").val(temp2);
        $(trr).find("div[name='tagName']").text(temp2);
        $(taa).find("input[name='tagName']").val(temp1);
        $(taa).find("div[name='tagName']").text(temp1);

        $(trr).find("input[name='tagSeq']").val(temp8);
        $(taa).find("input[name='tagSeq']").val(temp7);

        if(temp4 =='Y'){
            $(trr).find("input[name='isVisibled']").prop("checked",true);
        } else {
            $(trr).find("input[name='isVisibled']").prop("checked",false);
        }

        if(temp3 =='Y'){
            $(taa).find("input[name='isVisibled']").prop("checked",true);
        } else {
            $(taa).find("input[name='isVisibled']").prop("checked",false);
        }

        if(temp6==false){
            $(trr).find("button[name='editButton']").hide();
        } else {
            $(trr).find("button[name='editButton']").show();
        }

        if(temp5==false){
            $(taa).find("button[name='editButton']").hide();
        } else {
            $(taa).find("button[name='editButton']").show();
        }
    }
});


//순서정렬 위버튼
$(document).on("click","button[name='up']",function(){
    var tr = $(this).closest("tr");

    var index=$(tr).find("input[name='index']").val();
    var seq=$(tr).find("input[name='tagSeq']").val();

    var trr=$("#t"+index);
    var taa=$("#t"+(Number(index)-1));

    var temp1=$(trr).find("input[name='tagName']").val();
    var temp2=$(taa).find("input[name='tagName']").val();
    var temp7=$(trr).find("input[name='tagSeq']").val();
    var temp8=$(taa).find("input[name='tagSeq']").val();

    if( $(trr).find("input[name='isVisibled']").prop("checked")){
        temp3='Y';
    } else {
        temp3='N';
    }

    if( $(taa).find("input[name='isVisibled']").prop("checked")){
        temp4='Y';
    } else {
        temp4='N';
    }

    var temp5=$(trr).find("button[name='editButton']").is(":visible");
    var temp6=$(taa).find("button[name='editButton']").is(":visible");

    if(temp2 != null){
        $(trr).find("input[name='tagName']").val(temp2);
        $(trr).find("div[name='tagName']").text(temp2);
        $(taa).find("input[name='tagName']").val(temp1);
        $(taa).find("div[name='tagName']").text(temp1);

        $(trr).find("input[name='tagSeq']").val(temp8);
        $(taa).find("input[name='tagSeq']").val(temp7);

        if(temp4 =='Y'){
            $(trr).find("input[name='isVisibled']").prop("checked",true);
        } else {
            $(trr).find("input[name='isVisibled']").prop("checked",false);
        }

        if(temp3 =='Y'){
            $(taa).find("input[name='isVisibled']").prop("checked",true);
        } else {
            $(taa).find("input[name='isVisibled']").prop("checked",false);
        }

        if(temp6==false){
            $(trr).find("button[name='editButton']").hide();
        } else {
            $(trr).find("button[name='editButton']").show();
        }

        if(temp5==false){
            $(taa).find("button[name='editButton']").hide();
        } else {
            $(taa).find("button[name='editButton']").show();
        }
    }
});

//정렬저장버튼튼
$(document).on("click","#save",function(){
    $.ajax({
        url : "${pageContext.request.contextPath}/tag/updateTagMngOrdNo",
        type: "POST",
        data : $("#tagForm").serialize(),
        success : function(result){
            if(result == 1 ){

            } else {
                alert("저장에 실패했습니다.");
            }
        }
    });
});
</script>

