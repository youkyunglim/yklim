<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../../../sys/taglibs.jspf"%>
<%@ include file="../../../../../sys/setCodes.jspf"%>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="${js_src}/iosf/postcode/postcode.js" charset="UTF-8"></script>

<script type="text/javascript">
$(function() {
	/*alert("test")  */
});

_add = function(){
	$('#writeTable .tbl-inner').last().after($('#writeAdd').val());
}

</script>

<form:form modelAttribute="cmd" name="userProfileCommand" enctype="multipart/form-data" action="${url }?${iosf:params('') }" onsubmit="return doSubmit(this, 'post');">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KU_RFS</title>

    <link rel="stylesheet" href="../../../js/iosf/jquery-ui/jquery-ui.css"/>
    <link rel="stylesheet" href="../../../js/iosf/jquery-ui/jquery-ui.theme.css"/>
    
    <link rel="stylesheet" href="${css_src}/iosf/reset.css">
    <link rel="stylesheet" href="${css_src}/iosf/component/theme1/front/korean/common.css">
    <link rel="stylesheet" href="${css_src}/iosf/front/board_common.css"> 

    <script type="text/javascript" src="../../../js/jquery-1.12.4.min.js" ></script>
    <script type="text/javascript" src="../../../js/iosf/jquery-ui/jquery-ui.min.js"></script>
    <script type="text/javascript" src="../../../js/iosf/calendar/calendar.js"></script>
    <script type="text/javascript">var language = "ko", img_src ="/images",  css_src ="../../../css", js_src ="../../../js";theme = "/theme1";</script>
    <script type="text/javascript" src="../../../js/iosf/component/theme1/front/korean/controller.js" />
    <script type="text/javascript" src="../../../js/iosf/front/controller.js" ></script>
    <link rel="shortcut icon" type="image/x-icon" href="../../../favicon.ico" />
    <style type="text/css">
        body{
            padding: 20px;
        }
    </style>
</head>

<script type="text/javascript">

var files = null;

	function fileLoad(input) {
	    var file = input.files[0];	//????????? ?????? ????????????
	    
	    console.log(file);
	    files = input;
	    
	    var fileName = file.name;
	    var fileSize = file.size;
	    
	    $("#file-info").html(fileName + " [" + fileSize + "byte]" );
	    
	    /* 
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function(e) {
	        	$("#profile-img").prop("src", e.target.result);
	        };
	        reader.readAsDataURL(input.files[0]);
	      } else {
	    	  $("#profile-img").prop("src","");
	      }
	    
	    $(".file-box").hide();
	    $("#img-box").show();
 */	    
	
	};

	function validId(){
		
		if( $.trim($("#user_id").val()) == ""){
			alert("???????????? ??????????????????");
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
						alert("????????? ???????????? ????????????.");
					}else{
						alert("?????? ????????? ??????????????????.");
					}
				}else{
					alert("??????!!");
				}
			},
			error: function (xhr, status, error) {
                console.log("ERROR!!!");
            }
		});
	}
	
</script>

<body>
    <div class="comp-profile">
        <div class="prof-section">
            <div class="write-notice"><p>??? ????????? ????????? <strong class="red">??????????????????</strong>?????????, ????????? ????????? ?????????.</p></div>
            <span class="section-title">?????????/????????????</span>
            <div class="tbl-insert-holder">
                <table class="inserttbl">
                    <colgroup>
                        <col width="170px" />
                        <col />
                      </colgroup>
                    <tbody>
                        <tr>
                            <td class="td-label req">?????????</td>
                            <td>
                                <input type="text" name="user_id" id="user_id" value="${cmd.user_id }" placeholder="??????+?????? (4~12??????)" class="type5" />
                                <input type="text" name="user_seq" id="user_seq" value="${cmd.user_seq }" />
                                <input type="text" name="user_profile_seq" id="user_profile_seq" value="${cmd.user_profile_seq }" />
                                <button type="button" class="btn3 btn-grey" onclick="validId();">????????????</button>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label req">????????????</td>
                            <td><input type="text" name="pwd" id="pwd" value="${cmd.pwd }" placeholder="10~12?????? ??????+??????+???????????? ??? 2?????? ??????(????????? ????????? ?????? 3??? ?????? ?????? ?????? ??????)" class="type7" /></td>
                        </tr>
                        <tr>
                            <td class="td-label req">??????????????????</td>
                            <td><input type="password" name="pwd" id="pwd" value="${cmd.pwd }" placeholder="??????????????????????????????" class="type7" /></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div> 
        <div class="prof-section">
            <span class="section-title">????????????</span>
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
                            <td class="td-label req">????????? ??????</td>
                            <td colspan="3" class="for-upload">
                                <div class="attach-data">?????? ????????? : 140px*186px????????? ?????? : JPG, PNG</div>
                                <div class="files-uploaded">
                                    <ul>
                                        <li>
                                            <span class="file-icon">
                                                <span class="icon jpgnew">&nbsp;</span>
                                            </span>
                                            <span class="file-name">
                                                <em id="file-info">?????????_?????????.png [000byte]</em> &nbsp;<button class="btn-filedeleten">&nbsp;</button>
                                            </span> 
                                        </li>
                                    </ul>
                                </div>
                                <div class="attach-upload">
                                    <span class="input-box"><input type="file" name="" accept="image/*" onchange="fileLoad(this);" /></span>
                                    <span class="btn-box"><button class="btn-filedelete">&nbsp;</button></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label">??????</td>
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
                                            <td class="label req">??????</td>
                                            <td><input type="text" id="kor_nm" name="kor_nm" value="${mcmd.kor_nm }" /></td>
                                            <td class="label">??????</td>
                                            <td><input type="text" name="chn_nm" value="${mcmd.chn_nm }" placeholder="?????? ????????? ??????????????????." /></td>
                                        </tr>
                                        <tr>
                                            <td class="label req">?????????</td>
                                            <td><input type="text" name="eng_nm" value="${mcmd.eng_nm }" /></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label req">????????????</td>
                            <td>
                                <input type="text" value="${mcmd.birth_dt }" id="birth_dt" name="birth_dt" placeholder="0000-00-00" class="calendar"/>
                            </td>
                            <td class="td-label req">??????</td>
                            <td>
                                <select class="full" id="nation_cd" name="nation_cd">
                                    <option value="">:: ?????? ::</option>
									<iosf:option object="${codes.nation_cd }" select="${empty mcmd.nation_cd ? 'KOR' : mcmd.nation_cd }"/>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label req">??????</td>
                            <td>
                            	<label><iosf:radio name="gender_cd" value="M" label="??????" checked="${mcmd.gender_cd == 'M' || empty mcmd.gender_cd}"/><label>
                                <label><iosf:radio name="gender_cd" value="W" label="??????" checked="${mcmd.gender_cd == 'W'}"/><label>
                            </td>
                            <td class="td-label req">????????????</td>
                            <td>
                                <label><iosf:radio  name="disabled_yn" value="Y" label="??????" checked="${mcmd.disabled_yn == 'o'}"/></label>
                                <label><iosf:radio  name="disabled_yn" value="N" label="??????" checked="${mcmd.disabled_yn == '' }"/></label>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label req">E-MAIL</td>
                            <td><input type="text" name="email" value="${mcmd.email }" /></td>
                            <td class="td-label req">4?????????</td>
                            <td>							
                            	<c:forEach var="item" items="${iosf:codes('insu_cd') }" varStatus="i">
									<c:set var="isCheck" value="false"/>
 									<c:if test="${fn:contains(mcmd.insu_cds, item.key)  }">
 										<c:set var="isCheck" value="true"/>
 									</c:if>
										<label><iosf:checkbox name="insu_cds" value="${item.key}" checked="${isCheck }" />${item.value }</label>
							 </c:forEach>
							 </td>
                        </tr>
                        <tr>
                            <td class="td-label req">????????????</td>
                            <td>
<!--                                 <input type="text" value="" id="mobile1" class="type2" /> -
                                <input type="text" value="" id="mobile2" class="type2" /> -
                                <input type="text" value="" id="mobile3" class="type2" /> -->
                                <input type="number" value="${mcmd.mobile }" id="mobile" name="mobile"/>
                            </td>
                            <td class="td-label">?????????</td>
                            <td>
                                <span class="float">    
                                    <select class="type1">
                                        <option>??????</option>
                                        <option>????????????</option>
                                        <option>???????????????</option>
                                    </select>
                                </span>
<!--                                 <input type="text" value="" id="phone1" placeholder="000" class="type2" /> -
                                <input type="text" value="" id="phone2" placeholder="0000" class="type2" /> -
                                <input type="text" value="" id="phone3" placeholder="0000" class="type2" /> -->
                                <input type="text" value="${mcmd.phone }" id="phone" name="phone"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label req" rowspan="2">??????</td>
                            <td colspan="3" class="light-border">
                                <label><input type="radio" name="radio3" checked>????????????</label>
                                <label><input type="radio" name="radio3">????????????</label>
                            </td>
                        </tr>
                        <tr>
                            <td class="noborder" colspan="3">
                                <div class="row">
                                    <input type="text" value="${mcmd.zipcode }" name="zipcode" class="type4" />
                                    <button class="btn3 btn-grey">??????</button>
                                </div>
                                <div class="row"><input type="text" name="addr_1" value="${mcmd.addr_1 }" /></div>
                                <div class="row"><input type="text" name="addr_2" value="${mcmd.addr_2 }" /></div>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label req" rowspan="2">??????</td>
                            <td colspan="3" class="light-border">
                                <label><input type="radio" name="radio4">????????????</label>
                                <label><input type="radio" name="radio4" checked>????????????</label>
                            </td>
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
                                            <td colspan="3"><input type="text" name="eng_addr_1" value="${mcmd.eng_addr_1 }" placeholder="Address Line1??? ??????????????????." /></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Address Line2</td>
                                            <td colspan="3"><input type="text" name="eng_addr_2" value="${mcmd.eng_addr_2 }" placeholder="Address Line2??? ??????????????????." /></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Address Line3</td>
                                            <td colspan="3"><input type="text" name="eng_addr_3" value="${mcmd.eng_addr_3 }" placeholder="Address Line3??? ??????????????????." /></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Town/City</td>
                                            <td><input type="text" value="${mcmd.eng_citytown }" placeholder="Town/City??? ??????????????????." /></td>
                                            <td class="label">Province/State</td>
                                            <td><input type="text" value="${mcmd.eng_state }" placeholder="Province/State??? ??????????????????." /></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Postal Code</td>
                                            <td><input type="text" value="${mcmd.eng_postalcode }" placeholder="Postal Code??? ??????????????????." /></td>
                                            <td class="label">Country</td>
                                            <td><input type="text" value="${mcmd.eng_country_cd }" placeholder="Country??? ??????????????????." /></td>
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
            <span class="section-title">????????????</span>
            <div class="tbl-insert-holder">
                <table class="inserttbl nob">
                    <colgroup>
                        <col width="168px" />
                        <col />
                    </colgroup>
                    <tbody>
                        <tr>
                            <td class="td-label" rowspan="2">????????????</td>
                            <td><label><input type="checkbox" /> ????????????</label></td>
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
                                            <td class="td-label">?????????</td>
                                            <td><input type="text" placeholder="???????????? ??????????????????." /></td>
                                            <td class="td-label">??????</td>
                                            <td>
                                                <select class="type2">
                                                    <option>??????</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="td-label">??????</td>
                                            <td>
                                                <select class="type2">
                                                    <option>??????</option>
                                                </select>
                                            </td>
                                            <td class="td-label">????????????</td>
                                            <td>
                                                <input type="text" placeholder="0000-00-00" class="calendar" /> ~
                                                 <input type="text" placeholder="0000-00-00" class="calendar" />
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label" rowspan="2">????????????</td>
                            <td><label><input type="checkbox" checked /> ????????????</label></td>
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
                                            <td class="td-label">????????????</td>
                                            <td><input type="text" placeholder="0000-00-00" class="calendar" /></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="td-label">?????????/?????????</td>
                            <td id="writeTable">
                                <table class="tbl-inner">
                                    <colgroup>
                                        <col width="140px" />
                                        <col width="288px" />
                                        <col width="140px" />
                                        <col />
                                        <col width="42px" />
                                    </colgroup>
                                    <c:forEach var="row" items="${cmd.list_school}" varStatus="i">
                                    <tbody>
                                        <tr>
                                            <td class="td-label req">?????????</td>
                                            <td><input type="text" value="${row.school_nm }" placeholder="???????????? ??????????????????." /></td>
                                            <td class="td-label req">??????</td>
                                            <td><input type="text" placeholder="????????? ??????????????????." /></td>
                                            <td rowspan="3" class="nopad"><button class="btn-filedelete" disabled>&nbsp;</button></td>
                                        </tr>
                                        <tr>
                                            <td class="td-label req">????????????</td>
                                            <td>
                                                <select class="type2">
                                                    <option>??????</option>
                                                </select>
                                            </td>
                                            <td class="td-label">??????</td>
                                            <td><input type="text" placeholder="????????? ??????????????????." /></td>
                                        </tr>
                                        <tr>
                                            <td class="td-label req">??????</td>
                                            <td>
                                                <select class="type2">
                                                    <option>??????</option>
                                                </select>
                                            </td>
                                            <td class="td-label req">????????????</td>
                                            <td>
                                                <input type="text" placeholder="0000-00-00" class="calendar" /> ~
                                                <input type="text" placeholder="0000-00-00" class="calendar" />
                                            </td>
                                        </tr>
                                    </tbody>
                                   </c:forEach>
                                </table>
                                
                                <div class="float-right"><a href="javascript:void(0);" class="btn-addschool" onclick="_add();">?????????/????????? ??????</a></div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="bottom-buttons">
            <div class="btn-group align-center">
                <button type="submit" class="btn btn-orange icon icon-save">??????</button>
            </div>
        </div>
    </div>
</body>
	
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
        <tr>
            <td class="td-label req">?????????</td>
            <td><input type="text" name="school_nm" id="school_nm" value="${cmd.school_nm }" placeholder="???????????? ??????????????????." /></td>
            <td class="td-label req">??????</td>
            <td><input type="text" placeholder="????????? ??????????????????." /></td>
            <td rowspan="3" class="nopad"><button class="btn-filedelete">&nbsp;</button></td>
        </tr>
        <tr>
            <td class="td-label req">????????????</td>
            <td>
                <select name="hs_major_cd" id="hs_major_cd" class="type2" title="??????????????? ???????????????." onchange="_event();">
					<option value="">:: ???????????? ::</option>
					<iosf:option object="${codes.hs_major_cd }" select="${mcmd.hs_major_cd}"/>
				</select>
            </td>
            <td class="td-label">??????</td>
            <td><input type="text" placeholder="????????? ??????????????????." /></td>
        </tr>
        <tr>
            <td colspan="3" class="td-label req">????????????</td>
            <td>
                <input type="text" placeholder="0000-00-00" class="calendar" /> ~
                <input type="text" placeholder="0000-00-00" class="calendar" />
            </td>
        </tr>
    </tbody>
</table>
</textarea>