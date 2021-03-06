<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>


<html>
<head>
<title>구매상세조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

</head>

<body bgcolor="#ffffff" text="#000000">

<!--  table 1 : 구매상세조회 title -->
	<table width="100%" height="37" border="0" cellpadding="0"
		cellspacing="0">
		<tr>
			<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
				width="15" height="37" /></td>
			<td background="/images/ct_ttl_img02.gif" width="100%"
				style="padding-left: 10px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="93%" class="ct_ttl01">구매상세조회</td>
						<td width="20%" align="right">&nbsp;</td>
					</tr>
				</table>
			</td>
			<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
				width="12" height="37" /></td>
		</tr>
	</table>


<!--  table 2 : 구매상세조회 -->
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		style="margin-top: 13px;">

	<!-- tr1 : 물품번호 
		tranNo 주문번호 인지, prod_no 상품번호 인지 헷갈리고..  유저입장에서 필요한가?
	-->
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">물품번호 <img
				src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
			</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="105">${requestScope.purchase.purchaseProd.prodNo}</td>
						<td></td>
					</tr>
				</table>
			</td>
		</tr>

	<!-- tr2 : 구매자 아이디 -->
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">구매자아이디 <img
				src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
			</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${sessionScope.user.userId}</td>
		</tr>

	<!-- tr3 : 구매방법 -->
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">구매방법</td>
			<td bgcolor="D6D6D6" width="1"></td>
			
			<c:choose>
				<c:when test="${fn:startsWith(purchase.paymentOption,'1')}">
					<td class="ct_write01">현금구매</td>
				</c:when>
				
				<c:when test="${fn:startsWith(purchase.paymentOption,'2')}">
					<td class="ct_write01">신용구매</td>
				</c:when>
			
			</c:choose>
	
		</tr>

		<!-- tr4 : 구매자 이름 -->
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">구매자 이름</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${requestScope.purchase.receiverName}</td>
		</tr>

	<!-- tr5 : 구매자 연락처 -->
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">구매자 연락처</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${requestScope.purchase.receiverPhone}</td>
		</tr>

	<!-- tr6 : 구매자 주소 -->
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">구매자 주소</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${requestScope.purchase.divyAddr}</td>
		</tr>

	<!-- tr7 : 구매 요청사항 -->
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">구매 요청사항</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${requestScope.purchase.divyRequest}</td>
		</tr>

	<!-- tr8 : 배송희망일 -->
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>
		<tr>
			<td width="104" class="ct_write">배송희망일</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${requestScope.purchase.divyDate}</td>
		</tr>


	<!-- tr9 : 주문일 -->
		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>

		<tr>
			<td width="104" class="ct_write">주문일</td>
			<td bgcolor="D6D6D6" width="1"></td>
			<td class="ct_write01">${requestScope.purchase.orderDate}</td>
		</tr>

		<tr>
			<td height="1" colspan="3" bgcolor="D6D6D6"></td>
		</tr>

	</table>


<!--  table 3 : 수정, 확인 버튼 테이블 -->
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		style="margin-top: 10px;">
		<tr>
			<td width="53%"></td>
			<td align="right">
				<table border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="17" height="23"><img src="/images/ct_btnbg01.gif"
							width="17" height="23" /></td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01"
							style="padding-top: 3px;"><a
							href="/updatePurchaseView.do?tranNo=${requestScope.purchase.tranNo}">수정</a></td>
						<td width="14" height="23"><img src="/images/ct_btnbg03.gif"
							width="14" height="23" /></td>
						<td width="30"></td>
						<td width="17" height="23"><img src="/images/ct_btnbg01.gif"
							width="17" height="23" /></td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01"
							style="padding-top: 3px;"><a
							href="javascript:history.go(-1);">확인</a></td>
						<td width="14" height="23"><img src="/images/ct_btnbg03.gif"
							width="14" height="23" /></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

</body>
</html>
