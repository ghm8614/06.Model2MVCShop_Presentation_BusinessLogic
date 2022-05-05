<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>


<%--@ page import="java.util.List"--%>
<%--@ page import="com.model2.mvc.service.domain.Product"--%>
<%--@ page import="com.model2.mvc.common.Search"--%>
<%--@page import="com.model2.mvc.common.Page"--%>
<%--@page import="com.model2.mvc.common.util.CommonUtil"--%>


<%--
String menu = (String) request.getAttribute("menu");
Search search = (Search) request.getAttribute("search");
Page resultPage = (Page) request.getAttribute("resultPage");
List<Product> list = (List<Product>) request.getAttribute("list");

//==> null �� ""(nullString)���� ����
String searchCondition = CommonUtil.null2str(search.getSearchCondition());
String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
--%>


<html>
<head>
<title>��ǰ ����</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
	function fncGetDomainList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
		document.detailForm.submit();
	}

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">

	<!-- ��ü -->
		<form name="detailForm" action="/listProduct.do?menu=${menu}" method="post">


		<!-- table 1 : ��ǰ���� OR ��ǰ�����ȸ title -->
			<table width="100%" height="37" border="0" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
						width="15" height="37" /></td>
					<td background="/images/ct_ttl_img02.gif" width="100%"
						style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">


							<c:if test="${! empty menu && menu eq 'manage'}">
								<tr>
								<td width="93%" class="ct_ttl01">��ǰ ����</td>
								</tr>						
							</c:if>
							
							<c:if test="${! empty menu && menu eq 'search'}">
								<tr>
								<td width="93%" class="ct_ttl01">��ǰ ��� ��ȸ</td>
								</tr>						
							</c:if>


						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
						width="12" height="37" /></td>
				</tr>
			</table>


		<!-- table 2 : searchCondition, searchKeyword, �˻� ��ư ���̺�-->
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>

				<!-- condition, keyword -->
					<td align="right"><select name="searchCondition"
						class="ct_input_g" style="width: 80px">
							<option value="0"
								${search.searchCondition eq '0'? 'selected':''}>��ǰ��ȣ</option>
							<option value="1"
								${search.searchCondition eq '1'? 'selected':''}>��ǰ��</option>
							<option value="2"
								${search.searchCondition eq '2'? 'selected':''}>��ǰ����</option>
					</select> <input type="text" name="searchKeyword" value="${search.searchKeyword}"
						class="ct_input_g" style="width: 200px; height: 19px" /></td>

				<!-- �˻���ư -->
					<td align="right" width="70">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="17" height="23"><img
									src="/images/ct_btnbg01.gif" width="17" height="23"></td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01"
									style="padding-top: 3px;"><a
									href="javascript:fncGetDomainList(1);">�˻�</a></td>
								<td width="14" height="23"><img
									src="/images/ct_btnbg03.gif" width="14" height="23"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>


		<!-- table 3 : ��ǰ���� OR ��ǰ�����ȸ data ���̺� -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td colspan="11">��ü ${requestScope.resultPage.totalCount} �Ǽ�, ���� ${requestScope.resultPage.currentPage}
						������
					</td>
				</tr>

				<tr>
					<td class="ct_list_b" width="100">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">��ǰ��</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">����</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">�����</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">�������</td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="808285" height="1"></td>
				</tr>
				
				
				
				<c:set var="no" value="0"/>
				<c:forEach var="product" items="${list}">
					<c:set var="no" value="${no+1}" />
					<tr class="ct_list_pop">
						<td align="center">${no}</td>
						<td></td>
						
							<c:if test="${! empty menu && menu eq 'search'}">
								<td align="left"><a
								href="/getProduct.do?prodNo=${product.prodNo}&menu=search">${product.prodName}</a></td>
								<td></td>
								<td align="left">${product.price}</td>
								<td></td>
								<td align="left">${product.manuDate}</td>
								<td></td>
								
								<c:choose>
									<c:when test="${empty product.proTranCode}">
										<td align="left">�Ǹ���</td>
									</c:when>
									<c:when test="${! empty product.proTranCode}">
										<td align="left">������</td>
									</c:when>
								</c:choose>
							</c:if>
	
							<c:if test="${! empty menu && menu eq 'manage'}">
								<td align="left"><a
								href="/updateProductView.do?prodNo=${product.prodNo}&menu=manage">${product.prodName}</a></td>
								<td></td>
								<td align="left">${product.price}</td>
								<td></td>
								<td align="left">${product.manuDate}</td>
								<td></td>
								
								<c:choose>
									<c:when test="${empty product.proTranCode}">
										<td align="left">�Ǹ���</td>			
									</c:when>
									<c:when test="${fn:startsWith(product.proTranCode,'1')}">
										<td align="left">���ſϷ� <a href="/updateTranCodeByProd.do?prodNo=${product.prodNo}&tranCode=2">����ϱ�</a></td>
									</c:when>
									<c:when test="${fn:startsWith(product.proTranCode,'2')}">
										<td align="left">�����</td>
									</c:when>
									<c:when test="${fn:startsWith(product.proTranCode,'3')}">
										<td align="left">��ۿϷ�</td>
									</c:when>
								</c:choose>
								
							</c:if>
					
				</c:forEach>
										
				</tr>
				<tr>
					<td colspan="11" bgcolor="D6D7D6" height="1"></td>
				</tr>
			</table>


			<!-- PageNavigation Start... -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				style="margin-top: 10px;">
				<tr>
					<td align="center"><input type="hidden" id="currentPage" name="currentPage" value="" /> 
					 
					 <jsp:include page="../common/pageNavigator.jsp"/>
					 
					 </td>
				</tr>
			</table>
			<!-- PageNavigation End... -->



		</form>

	</div>
</body>
</html>