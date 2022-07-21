<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../../../sys/taglibs.jspf"%>
<%@ include file="../../../../../sys/setCodes.jspf"%>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="${js_src}/iosf/postcode/postcode.js" charset="UTF-8"></script>

	<%-- <form:form modelAttribute="cmd" name="userProfileCommand" enctype="multipart/form-data" action="${url }?${iosf:params('') }" onsubmit="return doSubmit(this, 'post');"> --%>
<head>
    <title>KU_RFS</title>

    <link rel="stylesheet" href="${css_src}/iosf/reset.css">
    <link rel="stylesheet" href="${css_src}/iosf/component/theme1/front/korean/common.css">
    <link rel="stylesheet" href="${css_src}/iosf/front/board_common.css"> 
    
    <script type="text/javascript" src="../../../js/jquery-1.12.4.min.js" ></script>
    <script type="text/javascript" src="../../../js/iosf/front/controller.js" ></script>
    <link rel="shortcut icon" type="image/x-icon" href="../../../favicon.ico" />
    <style type="text/css">
        body{
            padding: 20px;
        }
    </style>
</head>
<body>
    <div class="comp-profile">
        <div class="tbl-insert-holder">
            <table class="inserttbl">
                <colgroup>
                    <col width="170px" />
                    <col />
                  </colgroup>
                <tbody>
                    <tr>
                        <td class="td-label">아이디</td>
                        <td>${mcmd.user_id }</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="prof-section pad">
            <span class="section-title">인적사항</span>
            <div class="img-table">
                <div class="img-box"><img src="${configs.CONTEXT }/front/attach/preview/${mcmd.attach_idx }/254" /></div>
                <div class="tbl-box">
                    <table>
                        <tbody>
                            <colgroup>
                                <col width="124px" />
                                <col width="340px" />
                                <col width="124px" />
                                <col />
                            </colgroup>
                        </tbody>
                        <tr>
                            <td class="td-label">이름</td>
                            <td>${mcmd.kor_nm }</td>
                            <td class="td-label">영문이름</td>
                            <td>${mcmd.eng_nm }</td>
                        </tr>
                        <tr>
                            <td class="td-label">생년월일</td>
                            <td>${mcmd.birth_dt}</td>
                            <td class="td-label">국적</td>
                            <td><iosf:code upcd="nation_cd" cd="${mcmd.nation_cd}"/></td>
                        </tr>
                        <tr>
                            <td class="td-label">성별/장애여부</td>
                            <td><iosf:code upcd="gender_cd" cd="${mcmd.gender_cd}"/>/${mcmd.disabled_yn == 'Y' ? '장애있음' : '장애없음'}</td>
                            <td class="td-label">E-mail</td>
                            <td>${mcmd.email }</td>
                        </tr>
                        <tr>
                            <td class="td-label">휴대전화</td>
                            <td>${mcmd.mobile }</td>
                            <td class="td-label">사무실전화</td>
                            <td>${mcmd.phone }</td>
                        </tr>
                        <tr>
                            <td class="td-label">주소</td>
                            <td colspan="3">${mcmd.zipcode } ${mcmd.addr_1 } ${mcmd.addr_2 }</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="prof-section pad">
            <span class="section-title">학력사항</span>
            <table class="tbl-editor-grid border">
                <colgroup>
                    <col width="207px" />
                    <col width="84px" />
                    <col />
                    <col width="342px" />
                    <col width="90px" />
                </colgroup>
                <tbody>
                    <tr>
                        <td class="head">재학기간</td>
                        <td class="head">구분</td>
                        <td class="head">학교명(비고)</td>
                        <td class="head">전공</td>
                        <td class="head">최종학위</td>
                    </tr>
                    <c:forEach var="row" items="${cmd.list_school}" varStatus="i">
                    <tr>
                        <td align="center">
                        	<iosf:date format="${configs.FORMAT_DATE}" value="${row.start_dt }"/> ~ <iosf:date format="${configs.FORMAT_DATE}" value="${row.end_dt }"/>
                        </td>
                        <td align="center"><iosf:code upcd="enter_cd" cd="${row.enter_cd}"/></td>
                        <td>${row.school_nm}</td>
                        <td>${row.major_nm }</td>
                        <td align="center"><iosf:code upcd="degree_cd" cd="${row.degree_cd}"/></td>
                    </tr>
                    </c:forEach>
                     <tr>
                        <td align="center">0000-00-00 ~ 0000-00-00</td>
                        <td align="center">졸업</td>
                        <td>한양대학교 <br/>(이렇고 저렇고 해서 전입을 통해 전과 하였습니다.)</td>
                        <td>반도체공학과</td>
                        <td align="center">학사</td>
                    </tr>
                    <c:if test="${not empty mcmd.hs_pass_yn}">
	                    <tr>
	                        <td align="center">${mcmd.hs_pass_dt }(합격일자)</td>
	                        <td align="center">합격</td>
	                        <td>검정고시</td>
	                        <td>-</td>
	                        <td align="center">-</td>
	                    </tr>
                    </c:if>
                    <c:if test="${not empty mcmd.hs_nm}">
	                	<tr>
	                        <td align="center"><iosf:date format="${configs.FORMAT_DATE}" value="${mcmd.hs_start_dt }"/> ~ <iosf:date format="${configs.FORMAT_DATE}" value="${mcmd.hs_end_dt }"/></td>
	                        <td align="center">-</td>
	                        <td>${mcmd.hs_nm }</td>
	                        <td><iosf:code upcd="hs_major_cd" cd="${mcmd.hs_major_cd}"/></td>
	                        <td align="center">-</td>
	                    </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        <div class="bottom-buttons">
            <div class="section">
                <div class="btn-group float-right">
                  <button class="btn btn-mgreen icon icon-modify" onclick="location.href='/front/user/profile';">수정</button>
                </div>
            </div>
        </div>
    </div>
</body>
	
<%-- 	</form:form> --%>