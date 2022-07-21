<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../../../sys/taglibs.jspf"%>
<%@ include file="../../../../../sys/setCodes.jspf"%>

<link rel="stylesheet" type="text/css" href="${css_src}/iosf/front/board_common.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="${js_src}/iosf/postcode/postcode.js" charset="UTF-8"></script>

<script type="text/javascript">
$(function() {
	/*alert("test")  */
});

_add = function(){
	$('#writeTable .tbl-inner').last().after($('#writeAdd').val());
}

doPostSubmit = function(f) {
	
	if (f.pwd.value != f.pwd2.value) {
		alert('패스워드가 서로 다릅니다.');
		f.pwd2.focus();
		return false;
	}
	
	if (!confirm('저장하시겠습니까?')) {
		return false;
	}

	return true;
};

function fn_delete(o){
	$(o).closest("table").remove();
}

_deleteFile = function(o, idx, seq) {
	if (!confirm('삭제하시겠습니까?')) {
		return;
	}
	
	$('#file-info').val('');

/* 	$('#form_delete').remove();
	var deleteForm = $('<form id="form_delete" action="' + context + system_src + '/attach/' + seq + '" method="post" target="iframehidden"><input type="hidden" name="_method" value="delete"/><input type="hidden" name="attach_idx" value="' + idx + '"/></form>');
	deleteForm.appendTo('body');
	deleteForm.submit();
	
	$(o).closest('tbody').find('dl.hide').show();
	$(o).closest('dl').remove(); */
};

</script>

<script type="text/javascript">

	function validId(){
		
		if( $.trim($("#user_id").val()) == ""){
			alert("아이디를 입력해주세요");
			$("#user_id").focus();
		}
		
		var param = {
				user_id : $("#user_id").val()
		};
		
		$.ajax({
			url: context + "/front/user/profile/ajax",
			type: 'POST',
			contentType: "application/json; charset=UTF-8",
			dataType: "json",
			data: JSON.stringify(param),
			success: function(data){
				console.log(data);
				if(data != null){
					if(data.data == "Y"){
						alert("중복된 아이디가 있습니다.");
					}else{
						alert("사용 가능한 아이디입니다.");
					}
				}else{
					alert("오류!!");
				}
			},
			error: function (xhr, status, error) {
                console.log("ERROR!!!");
            }
		});
	}
	
	_deleteFile = function(o, idx, seq) {
		if (!confirm('삭제하시겠습니까?')) {
			return;
		}

//		$('#form_delete').remove();
//		var deleteForm = $('<form id="form_delete" action="' + context + system_src + '/attach/' + seq + '" method="post" target="iframehidden"><input type="hidden" name="_method" value="delete"/><input type="hidden" name="attach_idx" value="' + idx + '"/></form>');
//		deleteForm.appendTo('body');
//		deleteForm.submit();
		
	//	$(o).closest('tbody').find('dl.hide').show();
	//	$(o).closest('dl').remove();
	

		$("#attach_idx").val("");
		$("#input-read").html('<input type="file" name="files_attach_idx" accept="image/*"/>');
	};
	
</script>

<form:form modelAttribute="cmd" name="userProfileCommand" enctype="multipart/form-data" action="${url }/${cmd.user_seq }/write" onsubmit="return doSubmit(this, 'post');">
<body>
    <div class="comp-profile">
        <div class="prof-section">
            <div class="write-notice"><p>가 표기된 항목은 <strong class="red">필수입력항목</strong>입니다, 반드시 입력해 주세요.</p></div>
            <span class="section-title">아이디/비밀번호</span>
            <div class="tbl-insert-holder">
                <table class="inserttbl">
                    <colgroup>
                        <col width="170px" />
                        <col />
                      </colgroup>
                    <tbody>
                        <tr>
                            <td class="td-label">아이디</td>
                            <td>
                                <input type="hidden" name="user_id" id="user_id" value="${mcmd.user_id }" placeholder="영문+숫자 (4~12자리)" class="type5" />
                                ${mcmd.user_id }
                                <input type="hidden" name="user_seq" id="user_seq" value="${mcmd.user_seq }" />
                                <input type="hidden" name="user_profile_seq" id="user_profile_seq" value="${mcmd.user_profile_seq }" />
<!--                                 <button type="button" class="btn3 btn-grey" onclick="validId();">중복확인</button> -->
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label req">비밀번호 </td>
                            <td><input type="password" name="pwd" class="fullwidth ${isInsert ? '_req' : '' }" size="8" title="${isInsert ? '' : '수정할 ' }패스워드를 8자 이상 입력하세요" /></td>
                        </tr>
                        <tr>
                            <td class="td-label req">비밀번호확인</td>
                            <td><input type="password" name="pwd2" id="pwd2" value="" placeholder="●●●●●●●●●●" class="type7" /></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div> 
        <div class="prof-section">
            <span class="section-title">인적사항</span>
            <div class="tbl-insert-holder">
                <table class="inserttbl nob">
                    <colgroup>
                        <col width="168px" />
                        <col width="378px" />
                        <col width="168px" />
                        <col />
                    </colgroup>
                    <tbody>                      
                        <tr>
                            <td class="td-label req">프로필 사진</td>
                            <td colspan="3" class="for-upload">
                                <div class="attach-data">최적 사이즈 : 140px*186px│파일 형식 : JPG, PNG</div>
                                <div class="attach-upload">
								<c:if test="${empty mcmd.attach_seq }">                               
                                	<span class="input-box" id="input-file"><input type="file" name="files_attach_idx" accept="image/*" /></span>
                        		</c:if>
                        		<c:if test="${not empty mcmd.attach_seq }">                               
                                    <span class="input-box" id="input-read"><a href="${configs.CONTEXT }/back/attach/download/${mcmd.attach_idx }/${mcmd.attach_seq}">${mcmd.file_nm }</a> [<fmt:formatNumber value="${mcmd.file_size }" pattern="###,###" /> Byte]</span>
                        		</c:if>
                                    <span class="btn-box"><button type="button" class="btn-filedelete" onclick="_deleteFile(this,'${mcmd.attach_idx}', '${mcmd.attach_seq}');" >&nbsp;</button></span>
                                    <input type="hidden" id="attach_idx" name="attach_idx" value="${mcmd.attach_idx }">
                                </div>
                                
                            </td>
                        </tr>                        
                        <tr>
                            <td class="td-label">이름</td>
                            <td colspan="3">
                                <table class="tbl-inner">
                                    <colgroup>
                                        <col width="138px" />
                                        <col width="310px" />
                                        <col width="138px" />
                                        <col />
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <td class="label req">한글</td>
                                            <td><input type="text" id="kor_nm" name="kor_nm" value="${mcmd.kor_nm }" /></td>
                                            <td class="label">한문</td>
                                            <td><input type="text" name="chn_nm" value="${mcmd.chn_nm }" placeholder="한문 이름을 입력해주세요." /></td>
                                        </tr>
                                        <tr>
                                            <td class="label req">영문명</td>
                                            <td><input type="text" name="eng_nm" value="${mcmd.eng_nm }" /></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label req">생년월일</td>
                            <td>
                                <input type="text" format="${configs.FORMAT_DATE}" value="<iosf:date format="${configs.FORMAT_DATE}" value="${mcmd.birth_dt }"/>" id="birth_dt" name="birth_dt" placeholder="0000-00-00" class="calendar red"/>                                
                            </td>
                            <td class="td-label req">국적</td>
                            <td>
                                <select class="full" id="nation_cd" name="nation_cd">
                                    <option value="">:: 국적 ::</option>
									<iosf:option object="${codes.nation_cd }" select="${empty mcmd.nation_cd ? 'KOR' : mcmd.nation_cd }"/>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label req">성별</td>
                            <td>
                            	<label><input type="radio" name="gender_cd" value="M" <c:if test="${mcmd.gender_cd == 'M' || empty mcmd.gender_cd}">checked</c:if> >남성</label>
                            	<label><input type="radio" name="gender_cd" value="W" <c:if test="${mcmd.gender_cd == 'W'}">checked</c:if> >여성</label>
                            </td>
                            <td class="td-label req">장애여부</td>
                            <td>
                            	<label><input type="radio" name="disabled_yn" value="Y" <c:if test="${mcmd.disabled_yn == 'Y'}">checked</c:if> >있음</label>
                            	<label><input type="radio" name="disabled_yn" value="N" <c:if test="${mcmd.disabled_yn == 'N' || empty mcmd.disabled_yn}">checked</c:if> >없음</label>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label req">E-MAIL</td>
                            <td><input type="text" name="email" value="${mcmd.email }" /></td>
                            <td class="td-label req">4대보험</td>
                            <td>							
                            	<c:forEach var="item" items="${iosf:codes('insu_cd') }" varStatus="i">
									<c:set var="isCheck" value="false"/>
 									<c:if test="${fn:contains(mcmd.insu_cds, item.key)  }">
 										<c:set var="isCheck" value="true"/>
 									</c:if>
 										<label><input type="checkbox" name="insu_cds" value="${item.key }" <c:if test="${isCheck}">checked</c:if> >${item.value }</label>
							 </c:forEach>
							 </td>
                        </tr>
                        <tr>
                            <td class="td-label req">휴대전화</td>
                            <td>
<!--                                 <input type="text" value="" id="mobile1" class="type2" /> -
                                <input type="text" value="" id="mobile2" class="type2" /> -
                                <input type="text" value="" id="mobile3" class="type2" /> -->
                                <input type="number" value="${mcmd.mobile }" id="mobile" name="mobile"/>
                            </td>
                            <td class="td-label">연락처</td>
                            <td>
<!--                                 <span class="float">    
                                    <select class="type1">
                                        <option>선택</option>
                                        <option>자택전화</option>
                                        <option>사무실전화</option>
                                    </select>
                                </span> -->
<!--                                 <input type="text" value="" id="phone1" placeholder="000" class="type2" /> -
                                <input type="text" value="" id="phone2" placeholder="0000" class="type2" /> -
                                <input type="text" value="" id="phone3" placeholder="0000" class="type2" /> -->
                                <input type="text" value="${mcmd.phone }" id="phone" name="phone"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label req" rowspan="2">주소</td>
                            <td colspan="3" class="light-border">
                                <label><input type="radio" name="radio3" checked >국내거주</label>
                                <label><input type="radio" name="radio3">해외거주</label>
                            </td>
                        </tr>
                        <tr>
                            <td class="noborder" colspan="3">
                                <div class="row">
                                    <form:input path="zipcode" id="zipcode" class="type4" title="우편번호를 입력하세요" htmlEscape="false" readonly="true" />
                                    <iosf:button btnType="1" type="button" color="black" icon="search" value="주소 찾기" onclick="fnPostcode('zipcode', 'addr_1', 'addr_2');" />
                                </div>
                                <div class="row"><form:input path="addr_1" id="addr_1" class="fullwidth" title="주소를 입력하세요" htmlEscape="false" readonly="true" /></div>
							    <div class="row"><form:input path="addr_2" id="addr_2" class="reslifestudent_17 reslifeprofstaff_9 fullwidth" title="상세주소를 입력하세요" htmlEscape="false" /></div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label req" rowspan="2">주소</td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <table class="tbl-inner">
                                    <colgroup>
                                        <col width="138px" />
                                        <col width="310px" />
                                        <col width="138px" />
                                        <col />
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <td class="label">Address Line1</td>
                                            <td colspan="3"><input type="text" name="eng_addr_1" value="${mcmd.eng_addr_1 }" placeholder="Address Line1을 입력해주세요." /></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Address Line2</td>
                                            <td colspan="3"><input type="text" name="eng_addr_2" value="${mcmd.eng_addr_2 }" placeholder="Address Line2을 입력해주세요." /></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Address Line3</td>
                                            <td colspan="3"><input type="text" name="eng_addr_3" value="${mcmd.eng_addr_3 }" placeholder="Address Line3을 입력해주세요." /></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Town/City</td>
                                            <td><input type="text" value="${mcmd.eng_citytown }" name="eng_citytown" placeholder="Town/City를 입력해주세요." /></td>
                                            <td class="label">Province/State</td>
                                            <td><input type="text" value="${mcmd.eng_state }" name="eng_state" placeholder="Province/State를 입력해주세요." /></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Postal Code</td>
                                            <td><input type="text" value="${mcmd.eng_postalcode }" name="eng_postalcode" placeholder="Postal Code를 입력해주세요." /></td>
                                            <td class="label">Country</td>
                                            <td>
                                                <select class="full" id="eng_country_cd" name="eng_country_cd">
                                   					<option value="">:: 국적 ::</option>
												    <iosf:option object="${codes.nation_cd }" select="${mcmd.eng_country_cd }"/>
                               					</select>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="prof-section">
            <span class="section-title">학력사항</span>
            <div class="tbl-insert-holder">
                <table class="inserttbl nob">
                    <colgroup>
                        <col width="168px" />
                        <col />
                    </colgroup>
                    <tbody>
                        <tr>
                            <td class="td-label" rowspan="2">고등학교</td>
                        </tr>
                        <tr>
                            <td>
                                <table class="tbl-inner">
                                    <colgroup>
                                        <col width="140px" />
                                        <col width="288px" />
                                        <col width="140px" />
                                        <col />
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <td class="td-label">학교명</td>
                                            <td><input type="text" placeholder="학교명을 입력해주세요." name="hs_nm" value="${mcmd.hs_nm }" /></td>
                                            <td class="td-label">전공</td>
                                            <td>
                                                <select class="type2" name="hs_major_cd">
                                                    <option>선택</option>
                                                    <iosf:option object="${codes.hs_major_cd }" select="${mcmd.hs_major_cd}"/>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
<!--                                             <td class="td-label">구분</td>
                                            <td>
                                                <select class="type2">
                                                    <option>선택</option>
                                                </select>
                                            </td> -->
                                            <td class="td-label">재학기간</td>
                                            <td colspan="3">
                                            	<c:set var="hs_start_dt"><iosf:date format="${configs.FORMAT_DATE}" value="${mcmd.hs_start_dt }"/></c:set>
                                            	<c:set var="hs_end_dt"><iosf:date format="${configs.FORMAT_DATE}" value="${mcmd.hs_end_dt }"/></c:set>
                                                <input type="text" placeholder="0000-00-00" class="calendar red" name="hs_start_dt" value="${hs_start_dt }" /> ~
                                                <input type="text" placeholder="0000-00-00" class="calendar red" name="hs_end_dt" value="${hs_end_dt }" />
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label" rowspan="2">고등학교</td>
                            <td><label><input type="checkbox" checked /> 검정고시</label></td>
                        </tr>
                        <tr>
                            <td>
                                <table class="tbl-inner">
                                    <colgroup>
                                        <col width="140px" />
                                        <col />
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <td class="td-label">합격일자</td>
                                            <td>
                                            	<input type="text" name="hs_pass_dt" size="8" maxlength="10" class="calendar red" title="" placeholder="YYYYMMDD" value="<iosf:date format="${configs.FORMAT_DATE}" value="${mcmd.hs_pass_dt }"/>" />
                                        	</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label">대학교/대학원</td>
                            <td id="writeTable">
                            	<c:if test="${empty cmd.list_school}">
	                            <table class="tbl-inner">
                                    <colgroup>
                                        <col width="140px" />
                                        <col width="288px" />
                                        <col width="140px" />
                                        <col />
                                        <col width="42px" />
                                    </colgroup>
                                    <tbody>
                                    	<input type="hidden" name="status" value="U" />
                                        <tr>
                                            <td class="td-label req">학교명</td>
                                            <td><input type="text" value="${row.school_nm }" name="school_nms" placeholder="학교명을 입력해주세요." /></td>
                                            <td class="td-label req">전공유형</td>
                                            <td>
	                                            <select name="major_type_cd" class="type2">
													<iosf:option object="${codes.major_type_cd }" select="${row.major_type_cd }"/>
												</select
											</td>	
                                            <td rowspan="3" class="nopad">
                                            	<button type="button" class="btn-filedelete" onclick="" disabled>&nbsp;</button>
                                            </td>
                                        </tr>
                                        <tr>
                                        	<td class="td-label req">전공명</td>
                                            <td><input type="text" placeholder="전공을 입력해주세요." value="${row.major_nm }" name="major_nms" /></td>
                                            <td class="td-label req">최종학위</td>
                                            <td>
                                                <select class="type2" name="degree_cds">
                                                    <option>선택</option>
                                                    <iosf:option object="${codes.degree_cd }" select="${row.degree_cd}"/>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="td-label req">입학구분</td>
                                            <td>
                                                <select class="type2" name="enter_cds">
                                                    <option>선택</option>
                                                    <iosf:option object="${codes.enter_cd }" select="${row.enter_cd}"/>
                                                </select>
                                            </td>
                                            <td class="td-label req">재학기간</td>
                                            <td>
                                            	<c:set var="start_dt"><iosf:date format="yyyy-MM-dd" value="${row.start_dt }"/></c:set>
                                            	<c:set var="end_dt"><iosf:date format="yyyy-MM-dd" value="${row.end_dt }"/></c:set>
                                                <input type="text" placeholder="0000-00-00" class="calendar red" name="start_dts" value="${start_dt }" /> ~
                                                <input type="text" placeholder="0000-00-00" class="calendar red" name="end_dts" value="${end_dt }"/>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                </c:if>
                            	<c:forEach var="row" items="${cmd.list_school}" varStatus="i">
	                                <table class="tbl-inner">
	                                    <colgroup>
	                                        <col width="140px" />
	                                        <col width="288px" />
	                                        <col width="140px" />
	                                        <col />
	                                        <col width="42px" />
	                                    </colgroup>
	                                    <tbody>
	                                    	<input type="hidden" name="status" value="U" />
	                                        <tr>
	                                            <td class="td-label req">학교명</td>
	                                            <td><input type="text" value="${row.school_nm }" name="school_nms" placeholder="학교명을 입력해주세요." /></td>
	                                            <td class="td-label req">전공유형</td>
	                                            <td>
		                                            <select name="major_type_cd" class="type2">
														<iosf:option object="${codes.major_type_cd }" select="${row.major_type_cd }"/>
													</select
												</td>	
	                                            <td rowspan="3" class="nopad">
	                                            	<button type="button" class="btn-filedelete" onclick="fn_delete(this);" <c:if test="${i.index eq 0 }">disabled</c:if>>&nbsp;</button>
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                        	<td class="td-label req">전공명</td>
	                                            <td><input type="text" placeholder="전공을 입력해주세요." value="${row.major_nm }" name="major_nms" /></td>
	                                            <td class="td-label req">최종학위</td>
	                                            <td>
	                                                <select class="type2" name="degree_cds">
	                                                    <option>선택</option>
	                                                    <iosf:option object="${codes.degree_cd }" select="${row.degree_cd}"/>
	                                                </select>
	                                            </td>
	                                        </tr>
	                                        <tr>
	                                            <td class="td-label req">입학구분</td>
	                                            <td>
	                                                <select class="type2" name="enter_cds">
	                                                    <option>선택</option>
	                                                    <iosf:option object="${codes.enter_cd }" select="${row.enter_cd}"/>
	                                                </select>
	                                            </td>
	                                            <td class="td-label req">재학기간</td>
	                                            <td>
	                                            	<c:set var="start_dt"><iosf:date format="yyyy-MM-dd" value="${row.start_dt }"/></c:set>
	                                            	<c:set var="end_dt"><iosf:date format="yyyy-MM-dd" value="${row.end_dt }"/></c:set>
	                                                <input type="text" placeholder="0000-00-00" class="calendar red" name="start_dts" value="${start_dt }" /> ~
	                                                <input type="text" placeholder="0000-00-00" class="calendar red" name="end_dts" value="${end_dt }"/>
	                                            </td>
	                                        </tr>
	                                    </tbody>
	                                </table>
                                   </c:forEach>                                
                                <div class="float-right"><a href="javascript:void(0);" class="btn-addschool" onclick="_add();">대학교/대학원 추가</a></div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="bottom-buttons">
            <div class="btn-group align-center">
                <button type="submit" class="btn btn-orange icon icon-save">저장</button>
            </div>
        </div>
    </div>
	
</form:form>
	
<textarea cols="1" rows="1" hidden="hidden" id="writeAdd">
<table class="tbl-inner">
    <colgroup>
        <col width="140px" />
        <col width="288px" />
        <col width="140px" />
        <col />
        <col width="42px" />
    </colgroup>
    <tbody>
    	<input type="hidden" name="status" value="I" />
		<tr>
        	<td class="td-label req">학교명</td>
            <td><input type="text" name="school_nms" value="" placeholder="학교명을 입력해주세요." /></td>
            <td class="td-label req">전공유형</td>
            <td>
                <select name="major_type_cd" class="type2">
					<iosf:option object="${codes.major_type_cd }" select=""/>
				</select
			</td>
			<td rowspan="3" class="nopad"><button type="button" class="btn-filedelete" onclick="fn_delete(this);">&nbsp;</button></td>
		</tr>
        <tr>
        	<td class="td-label req">전공명</td>
            <td><input type="text" placeholder="전공을 입력해주세요." name="major_nms" value="" /></td>
        	<td class="td-label req">최종학위</td>
            <td>
            	<select class="type2" name="degree_cds">
                	<option>선택</option>
                    <iosf:option object="${codes.degree_cd }" select=""/>
				</select>
			</td>
		</tr>
        <tr>
        	<td class="td-label req">구분</td>
            <td>
            	<select class="type2" name="enter_cds">
                	<option>선택</option>
                    <iosf:option object="${codes.enter_cd }" select=""/>
					</select>
			</td>
            <td class="td-label req">재학기간</td>
			<td>
				<input type="text" placeholder="0000-00-00" class="calendar red" name="start_dts" value="" /> ~
            	<input type="text" placeholder="0000-00-00" class="calendar red" name="end_dts" value=""/>
			</td>
		</tr>
	</tbody>
</table>
</textarea>
