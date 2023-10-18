<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<sec:authentication property="principal.employee" var="empVO" />
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack-all.min.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack.min.css"
	rel="stylesheet" />

<link href="/resources/css/demo.css" rel="stylesheet" />

<style>
.reqQy {
	float: left;
	margin-bottom: 0;
}

#buttons {
	display: flex;
	align-items: center;
}

#searchBar {
	float: right;
	width: 30%;
}

#ii {
	width: 100%;
	height: 48%;
	margin-bottom: px;
}

#dd {
	width: 100%;
	height: 49%;
	margin-bottom: 10px;
}

.card-header {
	font-weight: bold;
	text-align: left;
}

.left-align {
	text-align: left;
	margin: 5px;
}

#uptable td {
	width: 50px;
	font-size: rem;
	letter-spacing: 0px;
}

.updateNO {
	width: 60px;
	margin: 0px 20px 10px 0px;
}

.rejectedStatus {
	color: red;
}

.success {
	color: blue;
}
#waitingListTable tr {
    height: 50px; 
}
a{
color: #697a8d;
font-size : 13px;
}
a:hover{
color : #697a8d;
}
td{
font-size : 13px;
}
</style>
<script>
// 화면이 시작하자마자 비품 신청현황 리스트 나오게하기
$(function() {

 	fSearch();
 	mediItemWaitingList("","");
    $("#upItem").prop("hidden", true);
	$("#delItem").prop("hidden", true);
	$("#upMediItem").prop("hidden", true);
	$("#delMediItem").prop("hidden", true);

// 	 if ($("#mediItem").hasClass("active")) {
// 			mediWaitingUpdata();
// 	    } else if ($("#item").hasClass("active")) {
// 	        itemWaitingUpdata();
// 	    }
    // 드롭다운 메뉴 선택 시 변경

    var oldBtnVal = "";
    let selectedLiId = "";
    $('#searchCtgr').text("선택");
    $('.dropdown-menu').on('click', '.searchCtgr', function () {
       // 선택한 드롭다운 메뉴
       
       let newBtnVal = $(this).text();
       selectedLiId = $(this).attr("id");
       console.log("선택된 li의 id:", selectedLiId);
        // 버튼값 업데이트
       $('#searchCtgr').text(newBtnVal); 

       // 이전 버튼값을 다시 드롭다운 메뉴에 추가
       if (oldBtnVal !== "") {
          $('.mediDropDown').append(oldBtnVal);
       }

       // 클릭된 항목의 부모인 <li> 태그를 삭제
       oldBtnVal = $(this).parent();
       //oldBtnVal.remove();
    });  
});	


	// 약품탭 클릭시 약품리스트 함수 호출
	function mediTab() {
		mediItemWaitingList("","");	
		// 비품,약품 상세보기 클릭시 (span태그) 상세 내역 출력하는함수
		$("#upMediItem").prop("hidden", true);
		$("#delMediItem").prop("hidden", true);
   		 $("#upItem").prop("hidden", true);
		$("#delItem").prop("hidden", true);
		$("#applicationList").text("신청목록")
		$("#upInputTable").empty();
		$("#uptable").empty();
		$('#searchCtgr').text("선택");
		$("#itemname").text("약품명");
		$("#itemcode").text("약품신청코드");
		$("#empname").text("약품신정자");		
	}

	// 비품 탭 클릭시 비품 리스트 함수를 호춯
	function itemTab(){
		
		itemWaitingList("","");
		// 비품,약품 상세보기 클릭시 (span태그) 상세 내역 출력하는함수
    	$("#upItem").prop("hidden", true);
		$("#upMediItem").prop("hidden", true);
		$("#delMediItem").prop("hidden", true);
		$("#delItem").prop("hidden", true);
		$("#applicationList").text("신청목록");
		$("#upInputTable").empty();
		$("#uptable").empty();
		$("#itemname").text("비품명");
		$("#itemcode").text("비품신청코드");
		$("#empname").text("비품신청자");
		$('#searchCtgr').text("선택");
	} 
	
	
	// 현재 활성화된 탭에 따라 검색 함수 호출
//     $("#searchButton").on("click", function() {
//     if ($("#mediItem").hasClass("active")) {
// //         searchMediItem(); // 약품 탭이 활성화되었을 때 약품 검색 함수 호출
    	
//     } else if ($("#item").hasClass("active")) {
// //         searchItem(); // 비품 탭이 활성화되었을 때 비품 검색 함수 호출
        
//     }
// 	});

   
        
  	      

  

// search 약품




// search 비품
//신청대기목록 th 함수 약품
function mediItemWaitingTh(){
	let row = `<thead style='position: sticky; top: 0;background-color: white;'><tr>
		<th style='position: sticky; top: 0;'>신청코드</th>
		<th style='position: sticky; top: 0;'>약품명</th>
		<th style='position: sticky; top: 0;'>발주신청일</th>
		<th style='position: sticky; top: 0;'>신청자</th>
		<th style='position: sticky; top: 0;'>상태</th>
		</tr></thead>`;
	return row;
}

//신청대기목록 th 함수 비품
function itemWaitingTh(){
	let row = `<thead style='position: sticky; top: 0;background-color: white;'><tr>
		<th style='position: sticky; top: 0;'>신청코드</th>
		<th style='position: sticky; top: 0;'>비품명</th>
		<th style='position: sticky; top: 0;'>발주신청일</th>
		<th style='position: sticky; top: 0;'>신청자</th>
		<th style='position: sticky; top: 0;'>상태</th>
		</tr></thead>`;
	return row;

}

//약품 리스트 함수
function mediItemWaitingList(searchType,keyword) {
	let data ={
			'searchType' : searchType,
			'keyword' : keyword
	}
   $.ajax({
      type: "post",
      url: "/item/mediItemWaitingList",
      contentType : "application/json; charset-utf-8",
      async: true,
      data : JSON.stringify(data),
      dataType: "JSON",
      success: function (rslt) {
    	  
         console.log("체크", rslt);
         let mediReqNo = rslt.mediItemReqNo;
         let newRow = mediItemWaitingTh();
         newRow += "<tbody>";

         // 중복된 mediItemReqNo를 추적하기 위한 배열
         let uniqueMediItemReqNo = [];

         // 중복된 mediItemReqNo에 대한 처리를 위한 객체
         let mediItemStatusMap = {};

         $.each(rslt, function (index, item) {
            if (!mediItemStatusMap.hasOwnProperty(item.mediItemReqNo)) {
               mediItemStatusMap[item.mediItemReqNo] = [];
            }

            // mediItemConfirmYsno 값을 mediItemStatusMap에 추가
            mediItemStatusMap[item.mediItemReqNo].push(item.mediItemConfirmYsno);
         });

         $.each(rslt, function (index, item) {
            if (uniqueMediItemReqNo.indexOf(item.mediItemReqNo) === -1) {
               // 중복되지 않은 mediItemReqNo인 경우에만 출력
               newRow += "<tr >";
               newRow += "<td><a href='#'>" + item.mediItemReqNo +"</a></td>";
               if (item.countMediItem > 1) { // 1 이상일 때 "외X"를 표시
                  newRow += "<td>" + item.mediItemName + '<p style="display:inline;"> 외' + (item.countMediItem -1)+ "</p></td>";
               } else { // 1 미만일 때는 표시하지 않음
                  newRow += "<td>" + item.mediItemName + "</td>";
               }
               newRow += "<td>" + item.mediItemReqDeStr + "</td>";
               newRow += "<td>" + item.empNm + "</td>";

               // 상태를 테이블 행 아래에 표시
               newRow += '<td>';
               const confirmYsnoArray = mediItemStatusMap[item.mediItemReqNo];

               if (confirmYsnoArray.includes("0") && confirmYsnoArray.includes("1")) {
                   newRow += '<span onclick="mediDtl(' + item.mediItemReqNo + ')" style="padding:5px" class="badge bg-label-success me-1 medi">처리중</span>';
                } else if (confirmYsnoArray.every(value => value === "1")) {
                   newRow += '<span onclick="mediDtl(' + item.mediItemReqNo + ')" style="padding:5px" class="badge bg-label-primary me-1 medi">승인</span>';
                } else if (confirmYsnoArray.every(value => value === "2")) {
                   newRow += '<span onclick="mediDtl(' + item.mediItemReqNo + ')" style="padding:5px" class="badge bg-label-danger me-1 medi">반려</span>';
                } else if (confirmYsnoArray.every(value => value === "0")) {
                   newRow += '<span onclick="mediDtl(' + item.mediItemReqNo + ')" style="padding:5px" class="badge bg-label-info me-1 medi">대기</span>';
                } else {
                   newRow += '<span onclick="mediDtl(' + item.mediItemReqNo + ')" style="padding:5px" class="badge bg-label-danger me-1 medi">반려</span>';
                }

               newRow += '</td>';
               newRow += "</tr>";

               uniqueMediItemReqNo.push(item.mediItemReqNo);
            }
         });

         newRow += "</tbody>";
         $("#waitingList").html(newRow);
      },
      error: function (xhr, status, error) {
         console.log("code: " + xhr.status);
         console.log("message: " + xhr.responseText);
         console.log("error: " + error);
      }
   });
}
// 비품 리스트 함수
function itemWaitingList(searchType,keyword){
	let data ={
			'searchType' : searchType,
			'keyword' : keyword
	}
	$.ajax({
		 type:"post",
		 data: JSON.stringify(data),
         url: "/item/ItemWaitingList",
         contentType : "application/json; charset-utf-8",
         async: true,
         dataType: "JSON",
         success: function(rslt) {
        	    console.log("체크22", rslt);
        	    
        	    let itemReqNo = item.itemReqNo;
        	    let newRow = itemWaitingTh();
        	    newRow += "<tbody>";
        	    let uniqueItemReqNo = []; // 중복된 itemReqNo를 처리하기 위한 배열
        	    let itemStatusMap = {};
        	    
        	    $.each(rslt, function (index, item) {
                    if (!itemStatusMap.hasOwnProperty(item.itemReqNo)) {
                    	itemStatusMap[item.itemReqNo] = [];
                    }

                    itemStatusMap[item.itemReqNo].push(item.itemConfirmYsno);
                 });
        	    
        	    $.each(rslt, function (index, item) {
        	        if (uniqueItemReqNo.indexOf(item.itemReqNo) === -1) {
        	          // 중복되지 않은 mediItemReqNo인 경우에만 출력
        	          
        	          newRow += "<tr style='height:10px;'>";
        	          newRow += "<td><a href='#'>" + item.itemReqNo +"</a></td>";
        	          if (item.countItem > 1) { 
        	        	    newRow += "<td>" + item.itemName + '<p style="color:red;display:inline;">외' + (item.countItem -1)+ "</p></td>";
        	        	} else { 
        	        	    newRow += "<td>" + item.itemName + "</td>";
        	        	}
        	          newRow += "<td>" + item.itemReqDeStr + "</td>";
        	          newRow += "<td>" + item.empNm + "</td>";
        	          
        	          
        	          // 상태를 테이블 행 아래에 표시
                      newRow += '<td>';
                      const confirmYsnoArray2 = itemStatusMap[item.itemReqNo];

                      if (confirmYsnoArray2.includes("0") && confirmYsnoArray2.includes("1")) {
                          newRow += '<span onclick="itemDtl(' + item.itemReqNo + ')" style="padding:5px" class="badge bg-label-success me-1 item">처리중</span>';
                       } else if (confirmYsnoArray2.every(value => value === "1")) {
                          newRow += '<span onclick="itemDtl(' + item.itemReqNo + ')" style="padding:5px" class="badge bg-label-primary me-1 item">승인</span>';
                       } else if (confirmYsnoArray2.every(value => value === "2")) {
                          newRow += '<span onclick="itemDtl(' + item.itemReqNo + ')" style="padding:5px" class="badge bg-label-danger me-1 item">반려</span>';
                       } else if (confirmYsnoArray2.every(value => value === "0")) {
                          newRow += '<span onclick="itemDtl(' + item.itemReqNo + ')" style="padding:5px" class="badge bg-label-info me-1 item">대기</span>';
                       } else {
                          newRow += '<span onclick="itemDtl(' + item.itemReqNo + ')" style="padding:5px" class="badge bg-label-danger me-1 item">반려</span>';
                       }

                      newRow += '</td>';
                      newRow += "</tr>";
        	          uniqueItemReqNo.push(item.itemReqNo); // 중복된 mediItemReqNo를 배열에 추가
        	        }
        	      });
        	    newRow+="</tbody>";

        	      $("#waitingList").html(newRow);
        	    },
        	    error: function (xhr, status, error) {
        	      console.log("code: " + xhr.status);
        	      console.log("message: " + xhr.responseText);
        	      console.log("error: " + error);
        	    },
        	  });
        	}
//약품 비품 공통 사용

var itemCodes = [];
var itemReqQys = [];

// 상세보기 클릭시  뜨고 alert 비품 수정 폼에 data뜨기
	
function itemDtl(param){
    $("#upItem").prop("hidden", true);
	$("#delItem").prop("hidden", true);
	let data ={"itemReqNo" : param};
    $.ajax({
    	type:"post",
    	data: JSON.stringify(data),
    	url: "/item/selectItemWaitingUpdate",
    	dataType : "json",
    	contentType :"application/json;charset=utf-8",
    	success : function(rslt){
    		
    		console.log("성공",rslt);
    		let wait = 0;
    		let app = 0;
    		let ret = 0;
    		var itemReqNo = rslt[0].itemReqNo;	
    		var str = '';
    		var strinput = '';
    		strinput += `
					<table class="table table-bordered" style="width:100%; margin:30px 0px 37px 0px;font-size:11px; white-space: nowrap;"> 
					  <tr>
	    			    <th>신청코드</th>
	    			    <th>신청일시</th>
	    			    <th>신청자</th>
				  	</tr>
				  	<tr>
				    	<td id="itemReqNo">\${rslt[0].itemReqNo}</td>
				    	<td>\${rslt[0].itemReqDeStr}</td>
				    	<td>\${rslt[0].empNm}</td>
				  	</tr>
				</table>	
					`;
	
		    str += '<table class="table table-bordered"style="width:100%; font-size:11px; white-space: nowrap;">';	    		    
		    str += "<thead>";	    		    
		    str += "<tr>";
		    str += "<td>선택</td>";
		    str += "<td>비품코드</td>";
		    str += "<td>비품명</td>" ;
		    str += "<td style='width:50px;'>신청수량</td>" ;
		    str += "<td>상태</td>" ;
		    str += "</tr>";
		    str += "</thead>";
		    str += "<tbody>";
		    
	    $.each(rslt, function(index, item) {
		      if (item.itemReqDetailVOList[0].itemConfirmYsno == "0") {
		         wait++;
		         console.log("0일때" ,wait);
		         console.log("wait " , wait);
		      } else if (item.itemReqDetailVOList[0].itemConfirmYsno == "1") {
		         app++;
		         console.log("1일때", app);
		      } else if (item.itemReqDetailVOList[0].itemConfirmYsno == "2") {
		         ret++;
		         console.log("2일때",ret);
		      }
   		})
		$.each(rslt, function(index, item) {
			if (app > 0) {
				   $("#upitem").attr("hidden", true);
				   $("#delitem").attr("hidden", true);
				   
				   str += "<tr>";
				      str += '<td><input type="checkbox" name="typArr" class="form-check-input checkClassItem" disabled data-medi-item-code="' + item.itemReqDetailVOList[0].itemCode + '" data-medi-item-req-qy=""></td>';
				      str += "<td class='mediItemCode'>" + item.itemReqDetailVOList[0].itemCode + "</td>";
				      str += "<td>" + item.itemName + "</td>";
				      str += "<td 'class='updateReqQy'>"+ item.itemReqDetailVOList[0].itemReqQy + "</td>";
				      if (item.itemReqDetailVOList[0].itemConfirmYsno == "1") {
				         str += "<td class='success'>승인</td>";
				      } else if (item.itemReqDetailVOList[0].itemConfirmYsno == "0") {
				         str += "<td>대기</td>";
				      }
				      str += "</tr>";
			}else if (ret > 0) {
				   $("#upitem").attr("hidden", true);
				   $("#delitem").attr("hidden", true);
				   str += "<tr>";
				      str += '<td><input type="checkbox" name="typArr" class="form-check-input checkClassItem" disabled data-medi-item-code="' + item.itemReqDetailVOList[0].itemCode + '" data-medi-item-req-qy=""></td>';
				      str += "<td class='mediItemCode'>" + item.itemReqDetailVOList[0].itemCode + "</td>";
				      str += "<td>" + item.itemName + "</td>";
				      str += "<td 'class='updateReqQy'>"+ item.itemReqDetailVOList[0].itemReqQy + "</td>";
				      if (item.itemReqDetailVOList[0].itemConfirmYsno == "2") {
				    	  if(item.itemReqDetailVOList[0].itemReturnWhy !==null){
				    		  
					         str += "<td class='rejectedStatus'>"+item.itemReqDetailVOList[0].itemReturnWhy+"</td>";
				    	  }else{
					          str += "<td>-</td>";
				      	  }
				      }
				      str += "</tr>";
			}else{
				   str += "<tr>";
	    		    str += '<td><input type="checkbox" name="typArr" class="form-check-input checkClassItem" data-medi-item-code="' + item.itemReqDetailVOList[0].itemCode + '" data-medi-item-req-qy=""></td>';
	    		    str += "<td class='mediItemCode'>" + item.itemReqDetailVOList[0].itemCode + "</td>";
	    		    str += "<td>" + item.itemName + "</td>" ;
	    		    str += "<td><input style='width:50px;' id='"+item.itemReqDetailVOList[0].itemCode+"'class='mediItemReqQy' type='number' value='" + item.itemReqDetailVOList[0].itemReqQy + "' class='updateReqQy' /></td>" ;
	    		    if(item.itemReqDetailVOList[0].itemConfirmYsno == "1"){
	    		    str += "<td>승인</td>" ;
	    		    }
	    		    else if(item.itemReqDetailVOList[0].itemConfirmYsno == "0"){
		    		    str += "<td>대기</td>" ;
		    		    }
	    		    else if(item.itemReqDetailVOList[0].itemConfirmYsno == "2"){
		    		    str += "<td>반려</td>" ;
		    		    }
	    		    str += "</tr>";
	    		    
		    
				    mediItemCodes.push(item.itemReqDetailVOList[0].itemCode);
				    mediItemReqQys.push(item.itemReqDetailVOList[0].itemReqQy);
	    		    $("#upItem").prop("hidden", false);
					$("#delItem").prop("hidden", false);
			}
		});
		
	        $("#uptable").html(str);
	        $("#upInputTable").html(strinput);

    	},
    	error: function (xhr, status, error) {
      	     console.log("code: " + xhr.status);
      	     console.log("message: " + xhr.responseText);
      	     console.log("error: " + error);
    	}
	
    })
}



var mediItemCodes = [];
var mediItemReqQys = [];
// 상세보기 클릭시  뜨고 alert 약품 수정 폼에 data뜨기

function mediDtl(param){

	    let data = {"mediItemReqNo":param};
	    $.ajax({
	    	type:"post",
	    	data : JSON.stringify(data),
	    	url : "/item/selectMediWaitingUpdate",
	    	dataType : "json",
	    	contentType:"application/json;charset=utf-8",
	    	success : function(rslt){
	    		console.log("데이터 가져오기: ",rslt);
	    		let wait = 0;
	    		let app = 0;
	    		let ret = 0;
	    		 var mediItemReqNo = rslt[0].mediItemReqNo;
	    		//데이터 가져오기: {"mediItemReqNo":104,"mediItemReqDe":1694762207000,"mediItemReqSt":null,"mediItemReqQy":0,"empNo":null,"empNM":null,"mediItemName":null,
	    		  //"mediItemReqDetailVOList":[{"mediItemReqNo":104,"mediItemCode":"640900630","mediItemReqQy":45,"mediItemReqTotal":0}]}
	    		var str = '';
	    		var strinput = '';
	    			strinput += `
	    						<table class="table table-bordered" style="width:100%; margin:30px 0px 37px 0px;font-size:11px; white-space: nowrap;"> 
			    				  <tr>
				    			    <th>신청코드</th>
				    			    <th>신청일시</th>
				    			    <th>신청자</th>
			    			  	</tr>
			    			  	<tr>
			    			    	<td id="mediItemReqNo">\${rslt[0].mediItemReqNo}</td>
			    			    	<td>\${rslt[0].mediItemReqDeStr}</td>
			    			    	<td>\${rslt[0].empNm}</td>
			    			  	</tr>
			    			</table>	
	    						`;
	    			
				   

	    		    str += '<table class="table table-bordered"style="width:100%; font-size:11px; white-space: nowrap;">';	    		    
	    		    str += "<thead>";	    		    
	    		    str += "<tr>";
	    		    str += "<td>선택</td>";
	    		    str += "<td>약품코드</td>";
	    		    str += "<td>약품명</td>" ;
	    		    str += "<td style='width:50px;'>신청수량</td>" ;
	    		    str += "<td>상태</td>" ;
	    		    str += "</tr>";
	    		    str += "</thead>";
	    		    str += "<tbody>";
	    		
	    		$.each(rslt, function(index, item) {
	    			//console.log("체킁:",index);
	    			//console.log("확인인디 -> ",item.mediItemReqDetailVOList[0].mediItemConfirmYsno);
    			      if (item.mediItemReqDetailVOList[0].mediItemConfirmYsno == "0") {
    			         wait++;
    			         console.log("0일때" ,wait);
    			         console.log("wait " , wait);
    			      } else if (item.mediItemReqDetailVOList[0].mediItemConfirmYsno == "1") {
    			         app++;
    			         console.log("1일때", app);
    			      } else if (item.mediItemReqDetailVOList[0].mediItemConfirmYsno == "2") {
    			         ret++;
    			         console.log("2일때",ret);
    			      }
	    		})
	    			 console.log("카운트 -->" ,wait,app,ret);
	    		$.each(rslt, function(index, item) {
	    			   if (app > 0) {
	    				   $("#upMediItem").attr("hidden", true);
	    				   $("#delMediItem").attr("hidden", true);
	    				      console.log("수정불가 조회만 가능");
	    				      str += "<tr>";
	    				      str += '<td><input type="checkbox" name="typArr" class="form-check-input checkClass" disabled data-medi-item-code="' + item.mediItemReqDetailVOList[0].mediItemCode + '" data-medi-item-req-qy=""></td>';
	    				      str += "<td class='mediItemCode'>" + item.mediItemReqDetailVOList[0].mediItemCode + "</td>";
	    				      str += "<td>" + item.mediItemName + "</td>";
	    				      str += "<td 'class='updateReqQy'>"+ item.mediItemReqDetailVOList[0].mediItemReqQy + "</td>";
	    				      
	    				      if (item.mediItemReqDetailVOList[0].mediItemConfirmYsno == "1") {
	    				         str += "<td class='success'>승인</td>";
	    				      } else if (item.mediItemReqDetailVOList[0].mediItemConfirmYsno == "0") {
	    				         str += "<td>대기</td>";
	    				      } else if (item.mediItemReqDetailVOList[0].mediItemConfirmYsno == "2") {
	    				         str += "<td>반려</td>";
	    				      }
	    				      str += "</tr>";
	    				   }else if (ret > 0) {
		    				   $("#upMediItem").attr("hidden", true);
		    				   $("#delMediItem").attr("hidden", true);
		    				      console.log("수정불가 조회만 가능");
		    				      str += "<tr>";
		    				      str += '<td><input type="checkbox" name="typArr" class="form-check-input checkClass" disabled data-medi-item-code="' + item.mediItemReqDetailVOList[0].mediItemCode + '" data-medi-item-req-qy=""></td>';
		    				      str += "<td class='mediItemCode'>" + item.mediItemReqDetailVOList[0].mediItemCode + "</td>";
		    				      str += "<td>" + item.mediItemName + "</td>";
		    				      str += "<td 'class='updateReqQy'>"+ item.mediItemReqDetailVOList[0].mediItemReqQy + "</td>";
		    				      if (item.mediItemReqDetailVOList[0].mediItemConfirmYsno == "2") {
		    				    	  if (item.mediItemReqDetailVOList[0].mediItemReturnWhy !== null) {
		    				    	        str += "<td class='rejectedStatus'>" + item.mediItemReqDetailVOList[0].mediItemReturnWhy + "</td>";
		    				    	    } else {
		    				    	        str += "<td>-</td>";
		    				    	    }

		    				      }
		    				      str += "</tr>";
		    				   }else{
		    					   str += "<tr>";
		    	 	    		    str += '<td><input type="checkbox" name="typArr" class="form-check-input checkClass" data-medi-item-code="' + item.mediItemReqDetailVOList[0].mediItemCode + '" data-medi-item-req-qy=""></td>';
		    	 	    		    str += "<td class='mediItemCode'>" + item.mediItemReqDetailVOList[0].mediItemCode + "</td>";
		    	 	    		    str += "<td>" + item.mediItemName + "</td>" ;
		    	 	    		    str += "<td><input style='width:50px;' id='"+item.mediItemReqDetailVOList[0].mediItemCode+"'class='mediItemReqQy' type='number' value='" + item.mediItemReqDetailVOList[0].mediItemReqQy + "' class='updateReqQy' /></td>" ;
		    	 	    		    if(item.mediItemReqDetailVOList[0].mediItemConfirmYsno == "1"){
		    	 	    		    str += "<td>승인</td>" ;
		    	 	    		    }
		    	 	    		    else if(item.mediItemReqDetailVOList[0].mediItemConfirmYsno == "0"){
		    	 		    		    str += "<td>대기</td>" ;
		    	 		    		    }
		    	 	    		    else if(item.mediItemReqDetailVOList[0].mediItemConfirmYsno == "2"){
		    	 		    		    str += "<td>반려</td>" ;
		    	 		    		    }
		    	 	    		    str += "</tr>";
		    		    		    
		    	 	    		    mediItemCodes.push(item.mediItemReqDetailVOList[0].mediItemCode);
		    	 	    		    mediItemReqQys.push(item.mediItemReqDetailVOList[0].mediItemReqQy);
		    	 	    		   $("#upMediItem").attr("hidden", false);
			    				   $("#delMediItem").attr("hidden", false);
		    				   }
	    			});
	    		    str += "</tbody>";
	    		    str += "</table>";
	   	        $("#uptable").html(str);
	   	        $("#upInputTable").html(strinput);

	    	},
    	    error: function (xhr, status, error) {
      	      console.log("code: " + xhr.status);
      	      console.log("message: " + xhr.responseText);
      	      console.log("error: " + error);
    	    }
	    	
	    })
	}
	
// function searchMediItem(fitem){

		
// 	console.log("mdeiItemVoList",mdeiItemVoList); // 위에 정의됨
// 	$.ajax({
// 		method:"get",
//          url: "/item/itemRequestSearchMediItem",
//          dataType : "json",
//          data: mdeiItemVoList,
//          success: function(rslt) {
//         	 console.log("체크", rslt);
//         	 var newRow = "";
//  	        newRow += mediItemtrtd();
 	        
//  	       $.each(rslt, function(index, item) {
//    	        // 각 열(td)에 데이터를 추가합니다.
//  	    	  newRow +="<tr>";
//   	        newRow +="<td><a href='#'>" + item.mediItemCode + "</a></td>";
//   	        newRow +="<td>" + item.mediItemName + "</td>";
//   	      	if(item.mediItemInvrQty<=item.mediItemLeastQty){
// 	        	newRow+='<td style="color:red;">' + item.mediItemInvrQty + "</td>";
// 	       		}else{
// 	       		newRow+='<td>' + item.mediItemInvrQty + "</td>";
// 			}
//   	        newRow +="<td>" + item.mediItemUnit + "</td>";
//   	        newRow +="<td>" + item.mediItemUsage + "</td>";
//   	        newRow +="<td>" + item.narcoticYn + "</td>";
//   	        newRow +="<td>" + item.mediItemLeastQty + "</td>";
//   	        var date = new Date(item.mediItemRegDate);
//   	        var year = date.getFullYear();
//   	        var month = (date.getMonth() + 1).toString().padStart(2, '0');
//   	        var day = date.getDate().toString().padStart(2, '0');
//   	        var formattedDate = year + '-' + month + '-' + day;
//   	        newRow +="<td>" + formattedDate + "</td>";
//   	        newRow +="</tr>";
//  	      });
// 	        $("#mediInventory").html(newRow);
//          },
//          error: function(xhr, status, error) {
//         	    console.log("code: " + xhr.status);
//         	    console.log("message: " + xhr.responseText);
//         	    console.log("error: " + error);
//         	}
// 	})
// }

</script>

<div class="grid-stack"></div>

<script type="text/javascript">
	
	// 그리드 스택 아이템 정의
	let gridStack1 = `<div id="div1" style="height:100%; width:100%; padding:0px;">

						<div class="input-group" id= "searchBar" style="margin:20px 10px 0px 10px; width: 41%;">
					    <div class="btn-group"style="width: 129px;">
					   	 	<button type="button" id="searchCtgr" class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false"></button>
					    	<ul class="dropdown-menu mediDropDown">
					       		<li><a class="dropdown-item searchCtgr" href="javascript:void(0);" id="itemcode" value="code">약품신청코드</a></li>
					       		<li><a class="dropdown-item searchCtgr" href="javascript:void(0);" id="itemname" value="name">약품명</a></li>
					       		<li><a class="dropdown-item searchCtgr" href="javascript:void(0);" id="empname" value="name">약품신청자</a></li>
					   		 </ul>
					 	</div>
							<span class="input-group-text"><i class="tf-icons bx bx-search"></i></span>
							<input type="text" style="margin-right:0px;" id="searchText"class="form-control" placeholder="Search...">
							<button type="button" id="searchButton"style="margin-left:0px;" onclick="fSearch()" class="btn btn-info">검색</button>
						</div><br><br>
						
						<div class="nav-align-top mb-4" style="width:100%;">
					      <ul class="nav nav-tabs" role="tablist" style="margin-left:25px;">
					        <li class="nav-item" role="presentation">
					          <button type="button" id="mediItem" class="nav-link active" onclick="mediTab()" role="tab" data-bs-toggle="tab" data-bs-target="#navs-top-home" aria-controls="navs-top-home" aria-selected="true">약품</button>
					        </li>
					        <li class="nav-item" role="presentation">
					          <button type="button" id="item" class="nav-link" role="tab"onclick="itemTab()"  data-bs-toggle="tab" data-bs-target="#navs-top-profile" aria-controls="navs-top-profile" aria-selected="false" tabindex="-1">비품</button>
					        </li>
					      </ul>
					        <div class="tab-pane fade show active" id="navs-top-home" role="tabpanel" style="height:113%;">
									<h4 class="card-header"id="applicationList"style="margin:0px;">신청목록</h4>
									
								 <div class="table-responsive text-nowrap" style="width:100%; overflow-y: auto; height: 580px;">
									<table class="table table-hover"id="waitingList"  style="">

									 </table>
								</div>	
					      </div>
					    </div>
						
					 </div>`;
	
	
    let gridStack3 = `<div id="div2" style="width:100%; height:100%; padding:10px; position: relative;">
					        <h5 class="card-header"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">상세조회</font></font></h5>
					        <div class="card-body"style="heigth:100% width:100%; padding:0px;">
					          <div id="upInputTable" style="width:100%;"></div>
					          
					          <div class="table-responsive text-nowrap" style="width:100%;" id="uptable">
					          </div>
					        </div>
					        <!-- 버튼을 우측 하단에 배치 -->
					        <div style="position: absolute; bottom: 10px; right: 10px;">
					            <button id="upMediItem" type="button" class="btn btn-primary">수정</button>
					            <button id="upItem" type="button" class="btn btn-primary" hidden>수정</button>
					            <button id="delMediItem"type="button" class="btn btn-secondary">삭제</button>
					            <button id="delItem"type="button" class="btn btn-secondary" hidden>삭제</button>
					        </div>
					</div>`;
						

// 그리드 스택 아이템 배열
var items = [
    { w: 7, h: 5, float: false, content: gridStack1 },
    { w: 5, h: 5, float: false, content: gridStack3 }
];

// 그리드 스택 초기화
var grid = GridStack.init();
grid.load(items);
</script>
<script>

// 수량 업데이트 약품
function updateMediQuantity(mediItemReqNo,mediItemCode,mediItemReqQy ) {
	
    let data={"mediItemReqNo" : mediItemReqNo, "mediItemCode" : mediItemCode, "mediItemReqQy": mediItemReqQy};
    // 예시: AJAX 요청을 사용하는 경우
    console.log("hdjklafhdskl",data);
    $.ajax({
        type: "post",
        data : JSON.stringify(data),
    	url : "/item/updateMediItemQy",
    	dataType : "json",
    	contentType:"application/json;charset=utf-8",
    	success : function(rslt){
            // 업데이트 성공 시 수행할 작업
             Swal.fire({
				icon: 'success',
				title: '완료!',
				text: "수정이 완료되었습니다.",
			});
            $("input[name=typArr]").prop("checked", false);
            mediItemWaitingList("","");
        },
        error:function(request,status,error){
            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
           }
    });
}
// 버튼 클릭시 약품 수정 함수 불러오기
 $("#upMediItem").on("click", function () {
 	let formData = new FormData();
	let mediItemReqNo = $("#mediItemReqNo").text();
	console.log("djfakl;djlsaf;jdxcksla;fjkdls;afjdksl;" ,mediItemReqNo);
	 Swal.fire({
			icon: 'warning',
			title: '수정',
			text: "수정하시겠습니까?",
		});;
 	$(".checkClass").each(function(idx){
 		if($(this).is(":checked")){
			let mediItemCode = $(this).data("mediItemCode");
			let mediItemReqQy=$('#'+mediItemCode).val();
 			console.log(mediItemCode);
 			console.log(mediItemReqQy);
 			
 			updateMediQuantity(mediItemReqNo,mediItemCode,mediItemReqQy);
 		}
		
 	})
 });
 
 function updateItemQuantity(itemReqNo,itemCode,itemReqQy) {
		
	    let data={"itemReqNo" : itemReqNo, "itemCode" : itemCode, "itemReqQy": itemReqQy};
	    // 예시: AJAX 요청을 사용하는 경우
	    console.log("나와라",data);
	    $.ajax({
	        type: "post",
	        data : JSON.stringify(data),
	    	url : "/item/updateItemQy",
	    	dataType : "json",
	    	contentType:"application/json;charset=utf-8",
	    	success : function(rslt){
	    		 Swal.fire({
	 				icon: 'success',
	 				title: '완료!',
	 				text: "수량이 업데이트 되었습니다.",
	 			});
	             $("input[name=typArr]").prop("checked", false);
	            itemWaitingList("","");
	        },
	        error:function(request,status,error){
	            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	           }
	    });
	}
 
 $("#upItem").on("click", function () {
	 	let formData = new FormData();
		let itemReqNo = $("#itemReqNo").text();
		console.log("데이이터" ,itemReqNo);

	 	$(".checkClassItem").each(function(idx){
	 		if($(this).is(":checked")){
				let itemCode = $(this).data("itemCode");
				let itemReqQy=$('#'+itemCode).val();
	 			console.log(itemCode);
	 			console.log(itemReqQy);
	 			
	 			updateItemQuantity(itemReqNo,itemCode,itemReqQy);
	 		}
			
	 	})
	 });
 function deleteMediItem(mediItemReqNo,mediItemCode) {
		
	    let data={"mediItemReqNo" : mediItemReqNo, "mediItemCode" : mediItemCode};
	    // 예시: AJAX 요청을 사용하는 경우
	    console.log("hdjklafhdskl",data);
	    $.ajax({
	        type: "post",
	        data : JSON.stringify(data),
	    	url : "/item/deleteMediItemDatail",
	    	dataType : "json",
	    	contentType:"application/json;charset=utf-8",
	    	success : function(rslt){
	            // 업데이트 성공 시 수행할 작업
            	$(".checkClass[data-mediItemCode='${mediItemCode}']").closest("tr").remove();
            	Swal.fire({
	 				icon: 'success',
	 				title: '완료!',
	 				text: "삭제 되었습니다.",
	 			});
               	mediItemWaitingList("","");
            	
	        },
	        error:function(request,status,error){
	            console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	           }
	    });
	}

 
 $("#delMediItem").on("click", function () {
	    let mediItemReqNo = $("#mediItemReqNo").text();

	    $(".checkClass").each(function (idx) {
	        if ($(this).is(":checked")) {
	            let mediItemCode = $(this).data("mediItemCode");
	          	
	            console.log(mediItemCode);
	            
	            deleteMediItem(mediItemReqNo, mediItemCode);
	            $(this).closest("tr").remove();

	        }
	    });
	});
 function deleteItem(itemReqNo,itemCode) {
		
	    let data={"itemReqNo" : itemReqNo, "itemCode" : itemCode};
	    // 예시: AJAX 요청을 사용하는 경우
	    console.log("비품 지워지는 값",data);
	    $.ajax({
	        type: "post",
	        data : JSON.stringify(data),
	    	url : "/item/deleteItemDatail",
	    	dataType : "json",
	    	contentType:"application/json;charset=utf-8",
	    	success : function(rslt){
	            // 업데이트 성공 시 수행할 작업
         		$(".checkClassItem[data-itemCode='${itemCode}']").closest("tr").remove();
	    		Swal.fire({
	 				icon: 'success',
	 				title: '완료!',
	 				text: "삭제 되었습니다.",
	 			});
	  
	    		itemWaitingList("","");
         	
	        },
	        error:function(request,status,error){
	        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	           }
	    });
	}

 
 
 $("#delItem").on("click", function () {
	    let itemReqNo = $("#itemReqNo").text();
	
	    $(".checkClassItem").each(function (idx) {
	        if ($(this).is(":checked")) {
	            let itemCode = $(this).data("itemCode");
	          	
	            console.log(itemCode);
	            
	            deleteItem(itemReqNo,itemCode);
	            $(this).closest("tr").remove();

	        }
	    });
	});

 function fSearch() {
	   let searchType = $('#searchCtgr').text();
	   let keyword = $('#searchText').val();
	   let data = {
	      searchType: searchType,
	      keyword: keyword
	   };
	   console.log("데이터는", data);
	   console.log("약품 신청 ", searchType);
	   if(searchType == "약품신청코드" || searchType=="약품명" || searchType == "약품신청자"){
		   mediItemWaitingList(searchType,keyword);
	   }else if (searchType == "비품신청코드" || searchType=="비품명" || searchType == "비품신청자"){
		   itemWaitingList(searchType,keyword);
	   }
	   
	}

 function fMessage() { // 받는쪽에 작성
		let serverMsg = JSON.parse(event.data);
		console.log("serverMsg", serverMsg);
		if (serverMsg.cmd == "alarm") {
			getNotiList();
		}

	}

</script>
