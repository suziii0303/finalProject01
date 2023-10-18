<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:authentication property="principal.employee" var="empVO" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack-all.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
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
	height: 44%;
	margin-bottom: 10px;
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
.form-group{
	display: flex;
	margin : 15px 0px 10px 5px;
}

.form-control.form-control-sm {
    width: 90%;
	
}

.form-label{
	width:90px;
	text-align:left;
}
.inputRequest{
	margin-left:15px;
}
#uptable tr th{
	text-align: center;  
}
#uptable tr td{
	height: 25px;  
	text-align: center;
}
#uptable{
	font-size: 12px; 
}
.gs-id-0 > .grid-stack-item[gs-h="6"] {
    height: 84.5%;
}
.grid-stack-item-content{
	overflow: none;
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
let rowIndexs;
$(function() {
	    // 페이지가 로드될 때 약품 리스트를 보이게 함
	    showMediList();
	    tabletrtd();
	    mediItemName();
	    setCheckboxBehavior();
	    $("#submitBtnItem").prop("hidden", true);
	    $("#submitBtnMedi").prop("disabled", false);
    	$("#submitBtnMedi").prop("hidden", false); // 약품
    	$("#autoFmedi").prop("hidden", false); 
    	$("#autoFitem").prop("hidden", true);
    	
	    // 약품 탭 클릭 이벤트 핸들러
	    $("#mediItem").on("click", function() {
	        showMediList(); // 약품 리스트 보이기
			tabletrtd();
			mediItemName();
        	$("#medicheck").text("약품신청확인");
        	$("#medicheckOK").text("약품신청");
        	$("#formItemCode").text("약품코드");
        	$("#formItemName").text("약품명");
        	$("#thItemCode").text("약품코드");
        	$("#thItemName").text("약품명");
        	 $("#itemCode").prev("label").text("약품코드");
 	        $("#itemName").prev("label").text("약품명");
        	$("#submitBtnMedi").prop("disabled", false);
        	$("#submitBtnItem").prop("disabled", true);
        	$("#submitBtnMedi").prop("hidden", false); // 약품 탭에서 버튼 표시
        	$("#submitBtnItem").prop("hidden", true);  // 비품 탭에서 버튼 숨김
 			$("#itemName").val("");
     		$("#itemCode").val("");
    	 	$("#reqQy").val("");
    	 	$("#itemCodeSelect").text("약품코드");
    	 	$("#itemNameSelect").text("약품명");
    	 	$('#searchCtgr').text("선택");
        	$("#autoFmedi").prop("hidden", false); 
        	$("#autoFitem").prop("hidden", true);
        	$("#chkAll").prop("checked", false);
        	rowIndex = 2;
        	setCheckboxBehavior();
	    });

	    // 비품 탭 클릭 이벤트 핸들러
	    $("#item").on("click", function() {
	        showItemList(); // 비품 리스트 보이기
			tabletrtd();
			itemName();
	        $("#medicheck").text("비품신청확인");
	        $("#medicheckOK").text("비품신청");
	        $("#formItemCode").text("비품코드");
	        $("#formItemName").text("비품명");
	        $("#thItemCode").text("비품코드");
	        $("#thItemName").text("비품명");
	        $("#itemCode").prev("label").text("비품코드");
	        $("#itemName").prev("label").text("비품명");
	        $("#submitBtnMedi").prop("disabled", true);
	        $("#submitBtnItem").prop("disabled", false);
	        $("#submitBtnMedi").prop("hidden", true);  // 약품 탭에서 버튼 숨김
	        $("#submitBtnItem").prop("hidden", false); // 비품 탭에서 버튼 표시
 			$("#itemName").val("");
     		$("#itemCode").val("");
     		$("#reqQy").val("");
    	 	$("#itemCodeSelect").text("비품코드");
    	 	$("#itemNameSelect").text("비품명");
    	 	$('#searchCtgr').text("선택");
    	    $("#autoFmedi").prop("hidden",true);  //비품 탭에서 약품버튼 숨김
    	    $("#autoFitem").prop("hidden",false);
    	    $("#chkAll").prop("checked", false);
    	    rowIndex = 2;
    	    setCheckboxBehavior();
     		
		});


	    // 검색 버튼 클릭 이벤트 핸들러
	    $("#searchButton").on("click", function() {
	        // 현재 활성화된 탭에 따라 검색 함수 호출
	        if ($("#mediItem").hasClass("active")) {
	            searchMediItem(); // 약품 탭이 활성화되었을 때 약품 검색 함수 호출
	        } else if ($("#item").hasClass("active")) {
	            searchItem(); // 비품 탭이 활성화되었을 때 비품 검색 함수 호출
	        }
	    });
	    $('#searchCtgr').text("선택");
	    $('#searchCtgr').on('click', function() {
	       // 현재 선택된 버튼값
	       let nowText = $('#searchCtgr').text();
	              
	       // 드롭다운 메뉴의 모든 값 표시
	       $('.dropdown-menu li').show(); 
	           
	       // 현재 선택된 버튼값과 같은 li 숨김
	      // $('.dropdown-menu li:contains(' + nowText + ')').hide(); 
	    });
	        
	    // 드롭다운 메뉴 선택 시 변경
	    var oldBtnVal = "";
	    let selectedLiId = "";
	    $('.item').on('click', '.searchCtgr', function () {
	       // 선택한 드롭다운 메뉴
	       let newBtnVal = $(this).text();
	       selectedLiId = $(this).attr("id");
	       console.log("선택된 li의 id:", selectedLiId);
	        // 버튼값 업데이트
	       $('#searchCtgr').text(newBtnVal); 

	       // 이전 버튼값을 다시 드롭다운 메뉴에 추가
	       if (oldBtnVal !== "") {
	          $('.item').append(oldBtnVal);
	       }

	       // 클릭된 항목의 부모인 <li> 태그를 삭제
	       oldBtnVal = $(this).parent();
	       //oldBtnVal.remove();
	    });

	    // 약품 리스트 출력 함수
	    function showMediList() {
	        $("#mediItem").addClass("active"); // 약품 탭 활성화
	        $("#item").removeClass("active"); // 비품 탭 비활성화
	        mediItemList(); // 약품 리스트 조회
	        $("#mediInventory").on("click", "td a", function () {
	            var codeValue = $(this).text();
	            $("#itemCode").val(codeValue);
				mediItemName();
	        });
	    }

	    // 비품 리스트 출력 함수
	    function showItemList() {
	        $("#item").addClass("active"); // 비품 탭 활성화
	        $("#mediItem").removeClass("active"); // 약품 탭 비활성화
	        itemList(); // 비품 리스트 조회
	        $("#mediInventory").on("click", "td a", function () {
	            var codeValue = $(this).text();
	            $("#itemCode").val(codeValue);
	            itemName();
	        });
	    }


	// 약/비품 신청 탭에서 취소를 눌렀을때
	$("#cancellItem").on("click",function(){
		$("#itemCode").val("");
		$("#itemName").val("");
		$("#reqQy").val("");
	});
	
	
	// 약/비품 신청 탭에서 확인를 눌렀을때 
	rowIndex = 2;
	$("#apcBtn").on("click", function () {
		//alert("aaa"+rowIndex);	
	    let code = $("#code").val();
	    let itemName = $("#itemName").val();
	    if (itemName.indexOf('_') !== -1) {
	        // 문자열에 언더스코어가 있는 경우에만 자르기
	        itemName = itemName.substring(0, itemName.indexOf('_'));
	    }
	    let itemCode = $("#itemCode").val();  // 약품 코드값
	    let reqDate = $("#reqDate").val();
	    let reqQy = $("#reqQy").val();
	    let tdValue = $('#uptable tr:nth-child(' + rowIndex + ') td:eq(1)').text().trim();
	    
	    console.log("???" ,code,itemName, itemCode,reqDate,reqQy);
		
		// 이미 추가 되어있으면 거부
		let exTrs = document.querySelectorAll("#uptable>tr");
		for(let i=0; i<exTrs.length; i++){
	
			if( exTrs[i].children[i]  && exTrs[i].children[i].innerHTML == itemCode){
				Swal.fire({
					icon: 'warning',
					title: '이미 넣은 약품입니다.',
					text: '다시 선택해주세요',
					});

				$("#itemCode").val("");
				$("#itemName").val("");
				$("#reqQy").val("");
				return;      // 함수 종료
			}else if(reqQy == ""){
				Swal.fire({
					icon: 'warning',
					title: '수량을 입력해 주세요',
					text: '',
					});
				return;
			}
		}
		
		//rowIndex 보정
		$(".uptableTrCounter").each(function(i){
			console.log(i + "번째 텍스트 : " + $(this).text());
			
			if($(this).text()!=""){
				rowIndex = (i+3);
				console.log("rowIndex : " + rowIndex);
			}
		});
		

		
	  	if(tdValue==""){
	    // 첫 번째 행의 각각의 td에 데이터 추가
	    	$('#uptable tr:nth-child('+rowIndex+') td:eq(0)').children().eq(0).attr("data-medi-item-code",itemCode).attr("data-medi-item-req-qy",reqQy);
	    	//$('#uptable tr:nth-child('+rowIndex+') td:eq(0)').children().eq(0).prop("checked",true);
		    $('#uptable tr:nth-child('+rowIndex+') td:eq(1)').text(itemCode); // 첫 번째 행의 두 번째 td
		    $('#uptable tr:nth-child('+rowIndex+') td:eq(2)').text(itemName); // 첫 번째 행의 세 번째 td
		    $('#uptable tr:nth-child('+rowIndex+') td:eq(3)').text(reqQy); // 첫 번째 행의 네 번째 td
		    $('#uptable tr:nth-child('+rowIndex+') td:eq(4)').text(reqDate); // 첫 번째 행의 다섯 번째 td
	    	
		    rowIndex++;
	  	}
	    
	    // 입력 필드 초기화
	
	    $("#itemName").val("");
	    $("#itemCode").val("");
	    $("#reqQy").val("");
	
	    console.log("체크으으으", code, itemName, itemCode, reqDate, reqQy);
	
});
	
// 	$("#cancelBtn").on("click", function () {
// 	    $('#uptable tr:gt(0)').find('td:gt(0)').each(function () {
// 	        $(this).text('');
// 	    });

// 	    // 입력 필드 초기화
// 	    $("#itemName").val("");
// 	    $("#itemCode").val("");
// 	    $("#reqQy").val("");
		
// 	 // rowIndex 변수 초기화
// 	    rowIndex = 2;
// 	});
// 	$("#cancelBtn").on("click", function () {
//     // 체크된 체크박스를 반복하여 처리
//     $('#uptable input[type="checkbox"]:checked').each(function () {
//         var $tr = $(this).closest('tr'); // 현재 체크박스의 부모 행 가져오기
//         var $tds = $tr.find('td:not(:first)'); // 체크박스를 제외한 모든 <td> \ 가져오기

//         // 각 <td>  대해 처리
//         $tds.each(function () {
//             var $td = $(this);
//             var currentText = $td.text().trim();

//             // 값이 이미 null이면 체크를 해제하고 해당 <td>는 수정하지 않음
//             if (currentText == "") {
//                 $td.siblings(':first').find('input[type="checkbox"]').prop("checked", false);
//             } else {
//                 $td.text(''); // 값이 null이 아니면 <td>의 내용을 지움
//             }
//         });
//         $tr.remove();
//     });

//     // 입력 필드 초기화
//     $("#itemName").val("");
//     $("#itemCode").val("");
//     $("#reqQy").val("");

//     // rowIndex 변수 초기화
//     rowIndex = 2;
// });
	


	
	// 이름 가져오는 함수 약품
	function mediItemName(){
	    	let code = $("#itemCode").val();
	    	
			console.log("약품 이름 가져오는  :",code);
			
			$.ajax({
				method:"get",
				url : "/item/InventoryInsertmediItemName",
				data: { "code" : code },
				dataType: "json",
				contentType:"application/json;charset=utf-8",
				success: function(rslt){
					console.log("코드2", rslt.mediItemName);
					 $("#itemName").val(rslt.mediItemName);
					
				},
				error: function(xhr, status, error) {
	        	    console.log("code: " + xhr.status);
	        	    console.log("message: " + xhr.responseText);
	        	    console.log("error: " + error);
	        	}
			})
	    }
	    // 이름 가져오는 함수 비품 
	    function itemName(){
	    	let code = $("#itemCode").val();
			
			console.log("비품 이름 가져오는 :",code);
			
			$.ajax({
				method:"get",
				url : "/item/InventoryInsertItemName",
				data: { "code" : code },
				dataType: "json",
				contentType:"application/json;charset=utf-8",
				success: function(rslt){
					console.log("코드2", rslt.itemName);
					 $("#itemName").val(rslt.itemName);
				},
				error: function(xhr, status, error) {
	        	    console.log("code: " + xhr.status);
	        	    console.log("message: " + xhr.responseText);
	        	    console.log("error: " + error);
	        	}
			})
	    }
	// 서치 ajax 함수 비품
	function searchItem(fitem){
		let itemVoList = {
			keyword : $("#searchText").val(),
			searchType: selectedLiId
		}
		
		//let searchText = $("#searchText").val();
		
		//console.log("메롱:",searchText);
		console.log("itemVoList",itemVoList); // 위에 정의됨
		
	    $.ajax({
	        method: "get",
	        url: "/item/InventorySearchItem",
	        data: itemVoList,
	        dataType: "JSON",
	        success: function (rslt) {
	        	 console.log("체크", rslt);
	        	 var newRow = "";
     	        newRow += itemtrtd();
     	        
     	       $.each(rslt, function(index, item) {
       	        // 각 열(td)에 데이터를 추가합니다.
       	        newRow +="<tr>";
       	    	newRow +="<td><a href='#'>" + item.itemCode + "</a></td>";
       	        newRow +="<td>" + item.itemName + "</td>";
       	        newRow +="<td>" + item.itemUsage + "</td>";
       	     	if(item.itemInvrQty<=item.itemInvrLeastQty){
	  	        	newRow += '<td style="color:red;">' + item.itemInvrQty + '</td>';
	  	        }else{
	      	        newRow +="<td>" + item.itemInvrQty + "</td>";	        	        	
	  	        }
       	        newRow +="<td>" + item.itemInvrLeastQty + "</td>";
	       	    var date = new Date(item.itemInvrRegDate);
	   	        var year = date.getFullYear();
	   	        var month = (date.getMonth() + 1).toString().padStart(2, '0');
	   	        var day = date.getDate().toString().padStart(2, '0');
	   	        var formattedDate = year + '-' + month + '-' + day;
	   	        newRow +="<td>" + formattedDate + "</td>";
       	        newRow +="</tr>";
     	      });
   	        $("#mediInventory").html(newRow);
	         },
	         error: function(xhr, status, error) {
	        	    console.log("code: " + xhr.status);
	        	    console.log("message: " + xhr.responseText);
	        	    console.log("error: " + error);
	        	}
		})
	}
	// 서치 ajax 함수 약품
	function searchMediItem(fitem){
		
		let mdeiItemVoList = {
				keyword : $("#searchText").val(),
				searchType: selectedLiId
			}
			
		console.log("mdeiItemVoList",mdeiItemVoList); // 위에 정의됨
		$.ajax({
			method:"get",
	         url: "/item/InventorySearchMediItem",
	         dataType : "json",
	         data: mdeiItemVoList,
	         success: function(rslt) {
	        	 console.log("체크", rslt);
	        	 var newRow = "";
     	        newRow += mediItemtrtd();
     	        
     	       $.each(rslt, function(index, item) {
       	        // 각 열(td)에 데이터를 추가합니다.
     	    	  newRow +="<tr>";
      	        newRow +="<td><a href='#'>" + item.mediItemCode + "</a></td>";
      	        newRow +="<td>" + item.mediItemName + "</td>";
      	      	if(item.mediItemInvrQty<=item.mediItemLeastQty){
  	        	newRow+='<td style="color:red;">' + item.mediItemInvrQty + "</td>";
  	       		}else{
  	       		newRow+='<td>' + item.mediItemInvrQty + "</td>";
				}
      	        newRow +="<td>" + item.mediItemUnit + "</td>";
      	        newRow +="<td>" + item.mediItemUsage + "</td>";
      	        newRow +="<td>" + item.narcoticYn + "</td>";
      	        newRow +="<td>" + item.mediItemLeastQty + "</td>";
      	        var date = new Date(item.mediItemRegDate);
      	        var year = date.getFullYear();
      	        var month = (date.getMonth() + 1).toString().padStart(2, '0');
      	        var day = date.getDate().toString().padStart(2, '0');
      	        var formattedDate = year + '-' + month + '-' + day;
      	        newRow +="<td>" + formattedDate + "</td>";
      	        newRow +="</tr>";
     	      });
   	        $("#mediInventory").html(newRow);
	         },
	         error: function(xhr, status, error) {
	        	    console.log("code: " + xhr.status);
	        	    console.log("message: " + xhr.responseText);
	        	    console.log("error: " + error);
	        	}
		})
	}
	
	function mediItemtrtd(fmediItemtrtd){
		let row = "<thead style='position: sticky; top: 0;background-color: white;'>";
	      row += "<tr>";
	      row += "<th style='position: sticky; top: 0;'>약품코드</th>";
	      row += "<th style='position: sticky; top: 0;'>약품명</th>";
	      row += "<th style='position: sticky; top: 0;'>재고수량</th>";
	      row += "<th style='position: sticky; top: 0;'>단위</th>";
	      row += "<th style='position: sticky; top: 0;'>용법</th>";
	      row += "<th style='position: sticky; top: 0;'>마약성여부</th>";
	      row += "<th style='position: sticky; top: 0;'>최소재고수량</th>";
	      row += "<th style='position: sticky; top: 0;'>최신발주일자</th>";
	      row += "</tr>";
	      row += "</thead>";
	      return row;
	}
	
	function itemtrtd(fitemtrtd){
		let row = "<thead style='position: sticky; top: 0;background-color: white;'>";
	      row += "<tr>";
	      row += "<th style='position: sticky; top: 0;'>비품코드</th>";
	      row += "<th style='position: sticky; top: 0;'>비품명</th>";
	      row += "<th style='position: sticky; top: 0;'>용도</th>";
	      row += "<th style='position: sticky; top: 0;'>재고수량</th>";
	      row += "<th style='position: sticky; top: 0;'>최소재고</th>";
	      row += "<th style='position: sticky; top: 0;'>최신발주일자</th>";
	      row += "</tr>";
	      row += "</thead>";
	      return row;
	}
	// 신청확인 테이블 함수
	function tabletrtd(fthis){
		
		let table =`<tr>
			<th>선택</th>
			<th id="thItemCode">약품코드</th>
			<th id="thItemName">약품명</th>
			<th>수량</th>
			<th>신청 일시</th>
		</tr>`;
		for(let i=1; i<=10;i++){
			table +="<tr>"
			table +='<td style="text-align: center; width:10px;"><input style="padding:0px;" type="checkbox" name="typArr" class="form-check-input typCls" data-medi-item-code="" data-emp-no="${empVO.empNo}" data-medi-item-req-qy=""></td>';
			table +='<td class="uptableTrCounter"></td>';
			table +='<td></td>';
			table +='<td></td>';
			table +='<td></td>';
			table +="</tr>";
				
		}
		$("#uptable").html(table);
		return table
	}
	$('#reqDate').val(new Date().toISOString().substring(0,10));
	
	// 신청 확인 - > 전체 전택 
	function setCheckboxBehavior() {
    $("#chkAll").click(function() {
        var isChecked = $(this).prop("checked");
        // 값이 있는 td에 해당하는 tr의 체크 박스만 체크
        $("td:nth-child(2):not(:empty)").closest("tr").find(".typCls").prop("checked", isChecked);
    });

    $("input[name=typArr]").click(function () {
        var isChecked = $(this).prop("checked");

        // 현재 체크된 체크 박스의 부모 행에서 2번째 <td>의 값을 가져옴
        var secondTdValue = $(this).closest("tr").find("td:nth-child(2)").text().trim();

        // 값이 없는 경우 체크 박스를 해제
        if (secondTdValue === "") {
            $(this).prop("checked", false);
        }

        var totalArr = $("td:nth-child(2):not(:empty)").closest("tr").find(".typCls").length;
        // 값이 있는 td에 해당하는 행의 체크된 체크 박스 개수
        var checked = $("td:nth-child(2):not(:empty)").closest("tr").find(".typCls:checked").length;

        // 개별 행의 체크 박스 상태에 따라 전체 선택 체크 박스 상태 변경
        $("#chkAll").prop("checked", totalArr === checked);
        // 체크 하나도 없으면 전체 체크 해제
        if (checked === 0) {
            $("#chkAll").prop("checked", false);
        }
    });
}

	  
	// 비품 리스트 함수
	function itemList(fItemList){
    	$.ajax({
			method:"get",
	         url: "/item/InventoryitemList",
	         async:true,
	         dataType : "json",
	         success: function(rslt) {
	        	    console.log("체크", rslt);
	        	   
        	        var newRow = "";
        	        newRow += itemtrtd();
                    newRow += '<tbody class="table-border-bottom-0">';
					
	        	    $.each(rslt, function(index, item) {
	        	        // 각 열(td)에 데이터를 추가합니다.
	        	        newRow +="<tr>";
	        	        newRow +="<td><a href='#'>" + item.itemCode + "</a></td>";
	        	        newRow +="<td>" + item.itemName + "</td>";
	        	        newRow +="<td>" + item.itemUsage + "</td>";
	        	        if(item.itemInvrQty<=item.itemInvrLeastQty){
	        	        	newRow += '<td style="color:red;">' + item.itemInvrQty + '</td>';
	        	        }else{
		        	        newRow +="<td>" + item.itemInvrQty + "</td>";	        	        	
	        	        }
		        	        newRow +="<td>" + item.itemInvrLeastQty + "</td>";
	        	        newRow +="<td>" + item.itemInvrRegDateStr + "</td>";
	        	        newRow +="</tr>";
	                    newRow +="</tbody>";
	        	        
	        	    });
	        	        $("#mediInventory").html(newRow);
	        	},
	        	error: function(xhr, status, error) {
	        	    console.log("code: " + xhr.status);
	        	    console.log("message: " + xhr.responseText);
	        	    console.log("error: " + error);
	        	}
		});
	}
	// 약품 리스트 함수
	function mediItemList(fMediList){
    	$.ajax({
			method:"get",
	         url: "/item/InventorymediList",
	         async:true,
	         dataType : "json",
	         success: function(rslt) {
	        	    console.log("체크", rslt);
        	        var newRow =  mediItemtrtd();
        	        newRow += '<tbody class="table-border-bottom-0">';
	        	    $.each(rslt, function(index, item) {
	        	        // 각 열(td)에 데이터를 추가합니다.
	        	        newRow +="<tr>";
	        	        newRow +="<td><a href='#'>" + item.mediItemCode + "</a></td>";
	        	        newRow +="<td style=''>" + item.mediItemName + "</td>";
	        	        if(item.mediItemInvrQty<=item.mediItemLeastQty){
	        	        	newRow+='<td style="color:red;">' + item.mediItemInvrQty + "</td>";
	        	       	}else{
	        	       		newRow+='<td>' + item.mediItemInvrQty + "</td>";
						}
	        	        newRow +="<td>" + item.mediItemUnit + "</td>";
	        	        newRow +="<td>" + item.mediItemUsage + "</td>";
	        	        newRow +="<td>" + item.narcoticYn + "</td>";

	        	        newRow +="<td>" + item.mediItemLeastQty + "</td>";
	        	        var date = new Date(item.mediItemRegDate);
	        	        var year = date.getFullYear();
	        	        var month = (date.getMonth() + 1).toString().padStart(2, '0');
	        	        var day = date.getDate().toString().padStart(2, '0');
	        	        var formattedDate = year + '-' + month + '-' + day;
	        	        newRow +="<td>" + formattedDate + "</td>";
	        	        newRow +="</tr>";
	                    newRow +="</tbody>";
	        	        
	        	    });
	        	        $("#mediInventory").html(newRow);
	        	},
	        	error: function(xhr, status, error) {
	        	    console.log("code: " + xhr.status);
	        	    console.log("message: " + xhr.responseText);
	        	    console.log("error: " + error);
	        	}
		});
	}
});

</script>

<div class="grid-stack"></div>

<script type="text/javascript">
	
	// 그리드 스택 아이템 정의
	let gridStack1 = `<div id="inventory" style=" height:97%; padding:0px;overflow: clip;">
      <h4 class="card-header" style="margin:17px 0px 0px 5px; font-weight:bolder;">재고현황</h5>
 

    <div class="input-group" id= "searchBar" style="margin-right: 10px;">
    <div class="btn-group">
    <button type="button" id="searchCtgr" style="width:97px; margin-right:10px;"class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false"></button>
    <ul class="dropdown-menu item">
       <li><a class="dropdown-item searchCtgr" href="javascript:void(0);" id="itemCodeSelect" value="code">약품코드</a></li>
       <li><a class="dropdown-item searchCtgr" href="javascript:void(0);" id="itemNameSelect" value="name">약품명</a></li>
    </ul>
 </div>
      <span class="input-group-text"><i class="tf-icons bx bx-search"></i></span>
      <input type="text" id="searchText"class="form-control" style="margin-right:0px;"laceholder="Search...">
      <button id="searchButton" type="button" class="btn btn-info" style="margin:0px 10px 0px 0px;">검색</button>
    </div><br>

     <ul class="nav nav-tabs" role="tablist" style="margin:0px 0px 0px 20px;" >
          <li class="nav-item" role="presentation">
            <button type="button"  id="mediItem" class="nav-link" role="tab" data-bs-toggle="tab" data-bs-target="#navs-top-home" aria-controls="navs-top-home" aria-selected="false" tabindex="-1">약품</button>
          </li>
          <li class="nav-item" role="presentation">
            <button type="button" id="item" class="nav-link" role="tab" data-bs-toggle="tab" data-bs-target="#navs-top-profile" aria-controls="navs-top-profile" aria-selected="false" tabindex="-1">비품</button>
     </ul>
  <div class="tab-content" style="width:100%; height:100%; padding: 10px;">

  <div class="card"  style="height:82%;">
      <div class="table-responsive text-nowrap" style="max-height: 100%; overflow-y:auto;">
        <table class="table table-hover" id="mediInventory" style="height:80%; width: 100%; ">

       </table>
  </div>
</div>
   </div>`;
     let gridStack2 = `<div id="div2" style="width:100%; height:100%; padding:20px;">
							<div id="ii" style="background-color:white;">
							<h5 id="medicheckOK" style="float:left; font-weight: bold;margin:10px 0px 10px 0px;">약품신청</h5></br></br>
							<input type="hidden"id="code"value="${empVO.empNo}"/>
						 <div class="form-group">
						    <label for="name" class="form-label" style="text-align:center;">신청자명 </label>
						    <input id="name" class="form-control form-control-sm inputRequest" type="text" placeholder="" value="${empVO.empNm}">
						  </div>
						  <div class="form-group">
						    <label for="itemCode" class="form-label" style="text-align:center;">약품코드</label>
						    <input id="itemCode" class="form-control form-control-sm inputRequest" type="text" placeholder="">
						  </div>
						  <div class="form-group">
						    <label for="itemName" class="form-label" style="text-align:center;">약품명</label>
						    <input id="itemName" class="form-control form-control-sm inputRequest" type="text" placeholder="">
						  </div>
						  <div class="form-group">
						    <label for="reqDate" class="form-label" style="text-align:center;">신청일시</label>
						    <input id="reqDate" class="form-control form-control-sm inputRequest" type="date" placeholder="">
						  </div>
						  <div class="form-group">
						    <label for="reqQy" class="form-label" style="text-align:center;">수량</label>
						    <input id="reqQy" class="form-control form-control-sm inputRequest" type="number" pattern="[0-9]+"  required placeholder="">
						  </div>
					       

					        <button type="button" style="margin-top:10px; float:right;margin-right:18px;" class="btn btn-secondary" id="cancellItem">취소</button>
							<button type="button" style="margin-top:10px; float:right; margin-right:10px;" class="btn btn-primary" id="apcBtn">확인</button><br><br>

		
						<div id="dd" style="background-color:white;text-align: left; margin-top: 30px;">
						<div style="display:flex;">
							<div><h5 id="medicheck"style="float: left;font-weight: bold; margin:5px 200px 0px 0px">약품신청확인</h5></div>
							<div>
							<label class="form-check-label" style="display: flex; align-items: center;">
							  <input class="form-check-input allCheck" style="margin-top: 10px;" type="checkbox" name="typArr" value="selectall" id="chkAll">
							  <span style="margin-top: 10px; margin-left:5px;">전체선택</span>
							</label>
							</div>
						</div>
						
						<div class="card" style="width: 100%; margin:20px 0px 30px 0px;">
						  <div class="table-responsive text-nowrap">
						    <table class="table table-hover" id="uptable" style="width: 100%; ">
						      <thead>

						      </thead>
						      <tbody class="table-border-bottom-0">
						        <tr>
						      
						      </tbody>
						    </table>
						  </div>
						</div>


							<button type="button" style="margin-top:-10px; float:right;"class="btn btn-secondary" id="cancelBtn">삭제</button>
							<button type="button" style="margin-top:-10px; margin-right : 10px;float:right;"class="btn btn-primary" id="submitBtnMedi">신청</button>
							<button type="button" style="margin-top:-10px; margin-right : 10px;float:right;"class="btn btn-primary"class="btn btn-primary" id="submitBtnItem">신청</button>
						</div>
							</div>
						</div>`;
// 그리드 스택 아이템 배열
var items = [
    { w: 9, h: 6, float: false, content: gridStack1 },
    { w: 3, h: 6, float: false, content: gridStack2 },
];

// 그리드 스택 초기화
var grid = GridStack.init();
grid.load(items);
</script>
<script type="text/javascript">
$(function(){
	//약품 신청
	$("#submitBtnMedi").on("click",function(){
		console.log("개똥이");
		$("#chkAll").prop("checked",false);
		//<form></form>
		let formData = new FormData();
		let hasCheckedMediItems = false;
		$(".typCls").each(function(idx){
			if($(this).is(":checked")){
				console.log($(this).data("mediItemCode"));
				console.log($(this).data("mediItemReqQy"));
				
				// <input type="text" name="mediItemReqDetailVOList[0].mediItemCode" value="52400801" />
				// <input type="text" name="mediItemReqDetailVOList[0].mediItemReqQy" value="2" />
				// <input type="text" name="mediItemReqDetailVOList[1].mediItemCode" value="622700220" />
				// <input type="text" name="mediItemReqDetailVOList[1].mediItemReqQy" value="1" />
				formData.append("mediItemReqDetailVOList["+idx+"].mediItemCode",$(this).data("mediItemCode"));
				formData.append("mediItemReqDetailVOList["+idx+"].mediItemReqQy",$(this).data("mediItemReqQy"));
				formData.append("mediItemReqDetailVOList["+idx+"].empNo",$(this).data("empNo"));
				hasCheckedMediItems = true;
			}
		});
		// 체크된 항목이 없으면 한 번만 alert 표시
		if (!hasCheckedMediItems) {
			Swal.fire({
				icon: 'error',
				title: '',
				text: '선택된 항목이 없습니다.',
				});
		}
		
		//아작나써유..피씨다타써
		$.ajax({
			url :"/item/insertTbMediItemRequest",
			processData : false,
			contentType : false,
			data : formData ,
			type : "post",
			success:function(result){
				if(result =="success"){
					Swal.fire({
						icon: 'success',
						title: '신청되었습니다',
						text: '',
						});
					clearSelectedRows();
				}else{
					Swal.fire({
						icon: 'error',
						title: '실패했습니다',
						text: '',
						});
				}
				$("#chkAll").prop("checked",false);
			},
			error: function(xhr, status, error) {
        	    console.log("code: " + xhr.status);
        	    console.log("message: " + xhr.responseText);
        	    console.log("error: " + error);
        	}
		});
	});
	
	//비품신청
	$("#submitBtnItem").on("click",function(){
		console.log("개똥이itme");
		
		//파일 전송 없으면 필요없음,FormData
		//let formData = new FormData();
		
		/*
			private int itemReqNo;
			private Date itemReqDe;
			private String itemReqSt;
			private String empNo;
	
			private List<ItemReqDetailVO> itemReqDetailVOList;
	*/
	
	/*
		private int itemReqNo;
		private String itemCode;
		private int itemReqQy;
		private int itemReqTotal;
		private int itemOrderNo;
		private String itemConfirmYsno;
		private Date itemOrderDate;
		private String itemReturnWhy;
		
		// 추가 (예린)
		private String itemName;
		private String itemMakr;
		private int itemPrice;
		private String itemReqDe;
		private String empNm;
	*/
	   
		
		 let itemReqVO = {
			empNo:"${empVO.empNo}",
			itemReqDetailVOList:[]	
		 }
		let hasCheckedItems = false;
		$(".typCls").each(function(idx){
			if($(this).is(":checked")){
				console.log($(this).data("mediItemCode"));
				console.log($(this).data("mediItemReqQy"));
				//               itemReqDetailVOList
				//formData.append("itemReqDetailVOList["+idx+"].itemCode",$(this).data("meditemCode"));
				//formData.append("itemReqDetailVOList["+idx+"].itemReqQy",$(this).data("mediItemReqQy"));
				//formData.append("itemReqDetailVOList["+idx+"].empNo",$(this).data("empNo"));
				
				let itemReqDetailVO = {
					itemCode: $(this).data("mediItemCode"),
					itemReqQy: $(this).data("mediItemReqQy"),	
				}
				itemReqVO.itemReqDetailVOList.push(itemReqDetailVO);
				hasCheckedItems = true;
			}
		});
		if (!hasCheckedItems) {
			Swal.fire({
				icon: 'error',
				title: '',
				text: '선택된 항목이 없습니다.',
				});
		}
		 console.log("체킁킁2:",itemReqVO);
	
		//아작나써유..피씨다타써
		$.ajax({
			url :"/item/insertTbItemRequest",
			//processData : false,
			//contentType : false,
			//data : formData,
			contentType:"application/json;charset=utf-8",
			data: JSON.stringify(itemReqVO),
			type : "post",
			success:function(result){
				if(result =="success"){
					Swal.fire({
						icon: 'success',
						title: '신청되었습니다',
						text: '',
						});
					clearSelectedRows();
					
				}else{
					Swal.fire({
						icon: 'error',
						title: '실패했습니다',
						text: '',
						});
				}
				$("#chkAll").prop("checked",false);
			},
			error: function(xhr, status, error) {
        	    console.log("code: " + xhr.status);
        	    console.log("message: " + xhr.responseText);
        	    console.log("error: " + error);
        	}
		});
	});
	function clearSelectedRows() {
	    // 체크된 체크박스를 반복하여 처리
	    $('#uptable input[type="checkbox"]:checked').each(function () {
	        var $tr = $(this).closest('tr'); // 현재 체크박스의 부모 행 가져오기
	        var $tds = $tr.find('td:not(:first)'); // 체크박스를 제외한 모든 <td> 요소 가져오기

	        // 각 <td> 요소에 대해 처리
	        $tds.each(function () {
	            var $td = $(this);
	            var currentText = $td.text().trim();

	            // 값이 이미 null이면 체크를 해제하고 해당 <td>는 수정하지 않음
	            if (currentText == "") {
	                $td.siblings(':first').find('input[type="checkbox"]').prop("checked", false);
	            } else {
	                $td.text(''); // 값이 null이 아니면 <td>의 내용을 지움
	            }
	        });
	        $tr.remove();
	        $("#uptable").append("<tr><td style='text-align: center; width:10px;'><input style='padding:0px;' type='checkbox' name=' typArr' class='form-check-input typCls' data-medi-item-code='' data-emp-no='${empVO.empNo}' data-medi-item-req-qy=''></td><td class='uptableTrCounter'></td><td></td><td></td><td></td><td></td></tr>");
	    });
	    
	    let cnt =0;
	    $(".uptableTrCounter").each(function(inx,jTd){
	    	//console.log("체킁킁:",inx," ",jTd);
	    	if($(jTd).html() !="") cnt++;
	    })

	    // 입력 필드 초기화
	    $("#itemName").val("");
	    $("#itemCode").val("");
	    $("#reqQy").val("");

	    //  변수 초기화
	    rowIndex = cnt+2;

	}
	
	// cancelBtn 클릭 시 clearSelectedRows 함수 실행
	$("#cancelBtn").on("click", function(){
		clearSelectedRows();
		
	});

});
function fMessage() { // 받는쪽에 작성
	let serverMsg = JSON.parse(event.data);
	console.log("serverMsg", serverMsg);
	if (serverMsg.cmd == "alarm") {
		getNotiList();
	}

}
</script>



