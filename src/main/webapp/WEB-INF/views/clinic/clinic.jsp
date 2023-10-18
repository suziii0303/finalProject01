<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
		<sec:authentication property="principal.employee" var="imsiVO" />
		<sec:authentication property="principal.employee" var="empVO" />
		<!DOCTYPE html>
		<html>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack-all.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
		<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
		<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
		<script src='/resources/js/jquery.zoom.js'></script>
		<script src='/resources/js/jquery.Wheelzoom.js'></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
		<link href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.0/gridstack.min.css" rel="stylesheet" />
		<link href="/resources/css/demo.css" rel="stylesheet" />

		<head>
			<meta charset="UTF-8">
			<title>진료실</title>
		</head>
		<style>
			.mygrid {
				border: 1px solid black;
			}

			.mygrid-title {
				text-align: right;
				font-size: 0.8 rem;
			}

			#dissModal,
			#inspcPhotoModal,
			#grpOrdModal {
				position: fixed;
				width: 1070px;
				height: 800px;
				background-color: white;
				display: none;
				z-index: 9999;
				top: 50%;
				left: 50%;
				transform: translate(-50%, -50%);
				/* 	border: 1px solid black; */
				overflow: auto;
			}

			#inspcModal,
			#treatModal,
			#physioModal {
				position: fixed;
				width: 750px;
				height: 800px;
				background-color: white;
				display: none;
				z-index: 9999;
				top: 50%;
				left: 50%;
				transform: translate(-50%, -50%);
				/* 	border: 1px solid black; */
				overflow: auto;
			}

			#detailModal {
				position: fixed;
				width: 480px;
				height: 465px;
				background-color: white;
				display: none;
				z-index: 9999;
				top: 50%;
				left: 50%;
				transform: translate(-50%, -50%);
				/* 	border: 1px solid black; */
				overflow: hidden;
			}

			.g-2 {
				margin: 15px;
			}

			#mediModal {
				position: fixed;
				width: 1380px;
				height: 720px;
				background-color: white;
				display: none;
				z-index: 9999;
				top: 50%;
				left: 50%;
				transform: translate(-50%, -50%);
				border: 1px solid black;
				overflow: auto;
			}

			.form-control {
				width: 35%;
				display: inline-block;
				margin-right: 15px;
			}

			.mb-3 {
				margin-bottom: 0.3rem !important;
			}

			.mb-4 {
				margin-bottom: 0.4rem !important;
				display: block;
			}

			.col-md-6 {
				width: auto;
			}

			.dropdown-toggle {
				margin: 10px;
			}

			.grid-stack-item-content {
				overflow: hidden;
			}

			.medi {
				width: 80px;
			}

			.mb-3 {
				text-align: left;
			}

			.form-control-sm {
				border: none;
			}

			.gs-id-0>.grid-stack-item[gs-h="2.5"] {
				height: 380px;
			}

			.gs-id-0>.grid-stack-item[gs-h="2.7"] {
				height: 400px;
			}

			.gs-id-0>.grid-stack-item[gs-h="3.5"] {
				height: 410px;
			}

			.gs-id-0>.grid-stack-item[gs-h="4.5"] {
				height: 660px;
			}

			.gs-12>.grid-stack-item[gs-w="6"] {
				width: 50%;
			}

			.gs-id-0>.grid-stack-item[gs-y="2.5"] {
				top: 373.333px;
			}

			.hidden-cell {
				display: none;
			}

			/* 감싸는 div */
			.wrap {
				position: relative;
				margin: 0 auto;
				width: 500px;
				height: 500px;
			}

			/* 확대될 타겟이미지*/
			.target {
				display: block;
				width: 100%;
			}

			/* 돋보기 */
			.magnifier {
				width: 160px;
				height: 160px;
				position: absolute;
				border-radius: 100%;
				box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.85), 0 0 3px 3px rgba(0, 0, 0, 0.25);
				display: none;
			}
		</style>

		<body>
			<!---------------------- 환자접수 상세정보 모달창 시작 ----------------------->
			<div class="modal-content" id="detailModal">
				<div class="modal-header">
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"
						onclick="closeDetailModal()"></button>
				</div>
				<div style="margin: 0px 0px 0px 61px;">
					<h4 class="pb-2 border-bottom mb-4"
						style="text-align: left; margin-right: 120px; font-weight: bold; width: 195px;">환자
						접수 상세정보</h4>
				</div>
				<form id="frmRecDet">
					<div class="modal-body">
						<div class="row" style="margin-left: 20px;">
							<div class="row g-2">
								<div class="col mb-0">
									<label for="Code" class="form-label"><strong>환자코드</strong></label>
									<input type="text" id="patCode1" class="form-control-sm" name="patCode"
										style="width: 144px;"> <label for="No"
										class="form-label"><strong>접수번호</strong></label> <input type="text"
										id="rceptNo1" class="form-control-sm" name="rceptNo" style="width: 100px;">
								</div>
							</div>
							<div class="row g-2">
								<div class="col mb-0">
									<label for="Name" class="form-label"><strong>이름</strong></label>
									<input type="text" id="patName1" class="form-control-sm" name="patName"> <label
										for="Age" class="form-label"><strong>나이</strong></label>
									<input type="text" id="patAge1" class="form-control-sm" name="patAge"
										style="width: 50px;">
								</div>

							</div>
							<div class="row g-2">
								<div class="col mb-0">
									<label for="GenCode" class="form-label"><strong>성별</strong></label>
									<input type="text" id="patGenCode1" class="form-control-sm" name="patGenCode">
									<label for="FirstExamCode" class="form-label"><strong>초재진여부</strong></label> <input
										type="text" id="rceptFirstExamCode1" class="form-control-sm"
										name="rceptFirstExamCode" style="width: 50px;">
								</div>
							</div>
							<div class="row g-2">
								<div class="col mb-0">
									<label for="HsptlzStatus" class="form-label"><strong>환자유형</strong></label>
									<input type="text" id="patHsptlzStatus1" class="form-control-sm"
										name="patHsptlzStatus" style="width: 146px;"> <label for="DayCode"
										class="form-label"><strong>주야간코드</strong></label>
									<input type="text" id="rceptDayCode1" class="form-control-sm" name="rceptDayCode"
										style="width: 50px;">
								</div>
							</div>
							<div class="row g-2">
								<div class="col mb-0">
									<label for="Brthdy" class="form-label"><strong>생년월일</strong></label>
									<input type="text" id="patBrthdy1" class="form-control-sm" name="patBrthdy"
										style="width: 146px;"> <label for="Time"
										class="form-label"><strong>접수일시</strong></label> <input type="text"
										id="receptTime1" class="form-control-sm" name="receptTime"
										style="width: 100px;">
								</div>

							</div>
							<div class="row g-2">
								<div class="col mb-0" style="display: flex;">
									<div style="display: flex;">
										<label for="Memo" class="form-label"
											style="margin-right: 10px;"><strong>접수메모</strong></label>
										<textarea id="rceptMemo1" rows="2" class="form-control-sm" name="rceptMemo"
											style="width: 286px; border: 1px solid #c6c6c6;"></textarea>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!--  //modal-body끝 -->
					<div class="modal-footer"></div>
				</form>
			</div>
			<!---------------------- 환자접수 상세정보 모달창 끝 ----------------------->



			<!---------------------- 검사오더 검색 모달창 시작 ----------------------->


			<div class="modal-content" id="inspcModal">
				<div style="margin: 30px 0px 10px 30px;">
					<h4 class="pb-2 border-bottom mb-4"
						style="text-align: left; margin-right: 120px; font-weight: bold; width: 140px;">검사오더
						목록</h4>
				</div>

				<div class="col mb-3">
					<input type="text" id="inspcType" class="form-control" style="margin: 10px 10px 0px 30px;"
						name="inspcType">
					<button type="button" class="btn btn-primary me-3" onclick="searchInspc()">검색</button>
				</div>

				<div id="inspcList"></div>

				<!--  //modal-body끝 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary me-3" onclick="checkInspc()">선택</button>
					<button type="button" class="btn btn-secondary me-3" data-bs-dismiss="modal"
						onclick="closeDetailModal()">닫기</button>
				</div>
			</div>
			<!---------------------- 검사오더 검색 모달창 끝 ----------------------->


			<!---------------------- 검사오더 결과 모달창 시작 ----------------------->
			<div class="modal-content" id="inspcPhotoModal">
				<div class="modal-header">
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"
						onclick="closeDetailModal()"></button>
				</div>
				<div style="margin: 0px 0px 0px 50px;">
					<h3 class="pb-2 border-bottom mb-4"
						style="text-align: left; margin: 0px 120px 8px 0px !important; font-weight: bold; width: 115px;">
						검사
						결과</h3>
				</div>
				<div class="card-body" style="display: flex; height: 85%;">
					<!-- 검사 이미지 감싸는 div -->
					<div class='wrap' style="width: 73%; height: 100%;">
						<!-- 검사 이미지 -->
						<img id="xrayImg" class="target" src="" data-zoom="1.5" style="width: 100%; height: 100%;" />
					</div>

					<!-- 오른쪽 검사 결과 리스트 -->
					<div style="padding: 10px; width: 40%;">
						<div class="table-responsive text-nowrap" id="inspcPhotoList"
							style="height: 100%; width: 100%; overflow-x: hidden;"></div>
					</div>
				</div>

				<!--  //modal-body끝 -->
				<div class="modal-footer"></div>
			</div>
			<!---------------------- 검사오더 결과 모달창 끝 ----------------------->


			<!---------------------- 처치오더 검색 모달창 시작 ----------------------->
			<div class="modal-content" id="treatModal">
				<div style="margin: 30px 0px 10px 30px;">
					<h4 class="pb-2 border-bottom mb-4"
						style="text-align: left; margin-right: 120px; font-weight: bold; width: 140px;">처치오더
						목록</h4>
				</div>

				<div class="col mb-3">
					<input type="text" id="treContent" class="form-control" style="margin: 10px 10px 0px 30px;"
						name="treContent">
					<button type="button" class="btn btn-primary me-3" onclick="searchTreat()">검색</button>
				</div>


				<div id="treatList"></div>

				<!--  //modal-body끝 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary me-3" onclick="checkTreat()">선택</button>
					<button type="button" class="btn btn-secondary me-3" data-bs-dismiss="modal"
						onclick="closeDetailModal()">닫기</button>
				</div>
			</div>
			<!---------------------- 처치오더 검색 모달창 끝 ----------------------->



			<!---------------------- 치료오더 검색 모달창 시작 ----------------------->
			<div class="modal-content" id="physioModal">
				<div style="margin: 30px 0px 10px 30px;">
					<h4 class="pb-2 border-bottom mb-4"
						style="text-align: left; margin-right: 120px; font-weight: bold; width: 185px;">물리치료오더
						목록</h4>
				</div>

				<div class="col mb-3">
					<input type="text" id="physioContent" class="form-control" style="margin: 10px 10px 0px 30px;"
						name="physioContent">
					<button type="button" class="btn btn-primary me-3" onclick="searchPhysio()">검색</button>
				</div>

				<div id="physioList"></div>

				<!--  //modal-body끝 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary me-3" onclick="checkPhysio()">선택</button>
					<button type="button" class="btn btn-secondary me-3" data-bs-dismiss="modal"
						onclick="closeDetailModal()">닫기</button>
				</div>
			</div>
			<!---------------------- 치료오더 검색 모달창 끝 ----------------------->


			<!---------------------- 질병오더 검색 모달창 시작 ----------------------->
			<div class="modal-content" id="dissModal">

				<div style="margin: 30px 0px 10px 30px;">
					<h4 class="pb-2 border-bottom mb-4"
						style="text-align: left; margin-right: 120px; font-weight: bold; width: 97px;">질병
						목록</h4>
				</div>

				<div class="col mb-3">
					<input type="text" id="dissKorName" class="form-control" style="margin: 10px 10px 0px 30px;"
						name="dissKorName">
					<button type="button" class="btn btn-primary me-3" onclick="searchDiss()">검색</button>
				</div>

				<div id="dissList"></div>
				<!--  //modal-body끝 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary me-3" onclick="checkDiss()">선택</button>
					<button type="button" class="btn btn-secondary me-3" data-bs-dismiss="modal"
						onclick="closeDetailModal()">닫기</button>
				</div>
			</div>
			<!---------------------- 질병오더 검색 모달창 끝 ----------------------->

			<!---------------------- 처방오더 검색 모달창 시작 ----------------------->
			<div class="modal-content" id="mediModal">

				<div style="margin: 30px 0px 10px 30px;">
					<h4 class="pb-2 border-bottom mb-4"
						style="text-align: left; margin-right: 120px; font-weight: bold; width: 140px;">처방오더
						목록</h4>
				</div>

				<div class="col mb-3">
					<input type="text" id="mediItemName" class="form-control" style="margin: 10px 10px 0px 30px;"
						name="mediItemName">
					<button type="button" class="btn btn-primary me-3" onclick="searchMedi()">검색</button>
				</div>

				<div id="mediList"></div>

				<!--  //modal-body끝 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary me-3" onclick="checkMedi()">선택</button>
					<button type="button" class="btn btn-secondary me-3" data-bs-dismiss="modal"
						onclick="closeDetailModal()">닫기</button>
				</div>
			</div>
			<!---------------------- 처방오더 검색 모달창 끝 ----------------------->


			<!---------------------- 오더매크로 조회 모달창 시작 ----------------------->
			<div class="modal-content" id="grpOrdModal">
				<div class="modal-header">
					<h3 class="modal-title" id="modalCenterTitle">그룹오더</h3>
				</div>

				<div id="grpOrdList"></div>
				<!--  //modal-body끝 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-primary me-3" id="grpOrdBtn" onclick="goGrpOrd()">등록</button>
					<button type="button" class="btn btn-secondary me-3" data-bs-dismiss="modal"
						onclick="closeDetailModal()">닫기</button>
				</div>
			</div>
			<!---------------------- 오더매크로 조회 모달창 끝 ----------------------->

			<div class="grid-stack"></div>

			<script type="text/javascript">
				// test('Spin-1s-200px.gif');

				// 			function test(imageName) {
				// 			    LoadingWithMask('loading.gif');
				// 			    setTimeout("closeLoadingWithMask()", 3000);
				// 			}

				// 			function LoadingWithMask(gif) {
				// 			    //화면의 높이와 너비를 구합니다.
				// 			    var maskHeight = $(document).height();
				// 			    var maskWidth  = window.document.body.clientWidth;
				// 			     console.log(gif);
				// 			    //화면에 출력할 마스크를 설정해줍니다.
				// 			    var mask       = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
				// 			    var loadingImg = '';
				// 			      let gif2 = "/resources/images/"+gif;
				// 			      console.log(gif2);  
				// 			    loadingImg += " <img src='"+ gif2 + "' style='position: absolute; display: block; margin: 0px auto;'/>";

				// 			    //화면에 레이어 추가
				// 			    $('body')
				// 			        .append(mask)

				// 			    //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채웁니다.
				// 			    $('#mask').css({
				// 			            'width' : maskWidth,
				// 			            'height': maskHeight,
				// 			            'opacity' : '0.3'
				// 			    }); 

				// 			    //마스크 표시
				// 			    $('#mask').show();

				// 			    //로딩중 이미지 표시
				// 			    $('#loadingImg').append(loadingImg);
				// 			    $('#loadingImg').show();
				// 			}

				// 			function closeLoadingWithMask() {
				// 			    $('#mask, #loadingImg').hide();
				// 			    $('#mask, #loadingImg').empty();  
				// 			}


				var empNo = ${ empVO.empNo };
				console.log(empNo);


				function fMessage() { // 받는쪽에 작성
					let serverMsg = JSON.parse(event.data);
					console.log("serverMsg", serverMsg);

					// 환자 접수 시
					if (serverMsg.cmd == "receiptPat") {
						getWaitPat();
					}

					// 검사 중
					if (serverMsg.cmd == "ingInspc") {
						getWaitPat();
					}

					// 검사 완료 시
					if (serverMsg.cmd == "endInspc") {
						getWaitPat();
						getEndInspcList();
					}

					// 알람 울렸을 때
					if (serverMsg.cmd == "alarm") {
						getNotiList();
					}
				}


				//맨처음 실행되는 함수
				$(function () {
					getWaitPat(); // 대기환자목록출력

					//enlargePhoto();
					// 클릭 이벤트 처리
					var a = "";
					$('.dropdown-menu').on('click', '.click-test', function () {
						//console.log("a는!!" + a);
						let value = $(this).text();
						$('.dropdown-menu').append(a);
						console.log("선택된 것은!!" + value);

						$('#testBtn').text(value);
						// 클릭된 항목의 부모인 <li> 태그를 삭제
						a = $(this).parent();
						a.remove();
					})
				});

				/////////////////////////  대기환자목록 시작  /////////////////////////////
				var gr1 =
					`	<div class="table-responsive text-nowrap" style="overflow:hidden;">
						    <table class="table table-hover" style="text-align : left;">
						      <thead>
						        <tr> 
						          <th style="text-align : center;" id="waitTotal"></th>
						        </tr>
						     </thead> 
						      <tbody class="table-border-bottom-0" id="waitTBody" style="border-bottom: 2px solid #d9dee3;">     
						      </tbody>
						    </table> 
					  	</div>`;
				/////////////////////////  대기환자목록 끝  /////////////////////////////



				///////////////////////////환자정보 시작/////////////////////////
				var gr2 =`					
				<div class="card-body">
						<div style="display:flex;">
						<div>
							<h5 class="pb-2 border-bottom mb-4" style="text-align:left; margin-right:120px; font-weight: bold; width: 75px;">환자정보 </h5>
						</div>
		
						<div style="margin-left: auto;">
							<button type="button" class="btn btn-primary me-3" onclick="recDetail()">접수상세보기</button>
						</div>
					</div>
		
					<div class="info-container">
						<div class="row">
							<div class="col-md-6">
								<ul class="list-unstyled">
									<li class="mb-3">
										<input type="hidden" name="rceptNo" class="form-control form-control-sm" id="rceptNo0" style="border:none;">
											<label class="form-label" style="width: 72px;"><strong>환자코드</strong></label>
											<input type="text" name="patCode" class="form-control form-control-sm" id="patCode0" style="width:40%;">
		
											</li>
											<li class="mb-3">
												<label class="form-label" style="width: 72px;"><strong>이름</strong></label>
												<input type="text" name="patName" class="form-control form-control-sm " id="patName0" style="width:50%;">
		
		
											</li>
											<li class="mb-3">
												<label class="form-label" style="width: 72px;"><strong>연락처</strong></label>
												<input type="text" name="patTel" class="form-control form-control-sm" id="patTel0" style="width:40%;">
		
											</li>
		
											<li class="mb-3">
												<label class="form-label"><strong>최초내원일자</strong></label>
												<input type="text" name="patFirstDate" class="form-control form-control-sm" id="patFirstDate0" style="width:40%;">
											</li>
											<li class="mb-3">
												<label class="form-label"><strong>최근내원일자</strong></label>
												<input type="text" name="patLastDate" class="form-control form-control-sm" id="patLastDate0" style="width:40%;">
											</li>
											<li class="mb-3">
												<label class="form-label" style="width: 72px;"><strong>주소</strong></label>
												<input type="text" name="patAddr" class="form-control form-control-sm" id="patAddr0" style="width:80%;">
											</li>
		
										</ul>
									</div>
							</div>
							<div class="d-flex justify-content-center pt-3">
							</div>
						</div>
					</div>
				</div>`
				///////////////////////////환자정보 끝/////////////////////////


				//////////////////////////////////날짜로 검색한 차트 시작////////////////////////////////////////////////////      

				var gr3 =
					`<div style="display:flex;"><div id="disp" style="float:left; display:none;"></div>
						<div class="card-body">
						<div style="display:flex;">
							<div>
								<h5 class="pb-2 border-bottom mb-4"  style="text-align: left; margin-right: 106px; font-weight: bold; width: 75px;">진료내역</h5>
							</div>
							<div>
								<small id="firstPat" style="color:red; font-weight: bold; display:none;">※금일 첫 내원 환자로 진료내역이 존재하지 않습니다.</small>
							</div>
						</div>
						 <div class="mb-3">
				          <input type="text" name="rceptFirstExamCode" class="form-control-sm " id="rceptFirstExamCode2" style="width:15%; margin:0px;">
				          <input type="text" name="rceptDayCode" class="form-control-sm " id="rceptDayCode2" style="width:15%; margin:0px;">
				          <input type="text" name="clnicSttusCode" class="form-control-sm " id="patHsptlzStatus2" style="width:35%; margin:0px;">
				         </div>
				            <div class="mb-3">
				               <label class="form-label chartloglabel"><strong>증상메모</strong></label><br>
				               <input type="text" class="form-control-sm chartlog" name="detailMemo" id="detailMemo2" style="width:90%;">
				            </div>  
				            <div class="mb-3">
				                <label class="form-label chartloglabel"><strong>질병</strong></label><br>
				                <input type="text" name="dissKorName" class="form-control-sm chartlog" id="dissKorName2">
				            </div>
				            <div class="mb-3">
							<label class="form-label chartloglabel"><strong>오더내역</strong></label><br>
							<label class="form-label">검사</label>
							<input type="text" name="inspcType" class="form-control-sm chartlog" id="inspcType2" style="width:90%;"><br>
							<label class="form-label">처치</label>
							<input type="text" name="treContent" class="form-control-sm chartlog" id="treContent2" style="width:90%;"><br>
							<label class="form-label">치료</label>
							<input type="text" name="physioContent" class="form-control-sm chartlog" id="physioContent2" style="width:90%;">
				            </div>
				            <div class="mb-3">
				               <label class="form-label chartloglabel"><strong>처방내역</strong></label><br>
				               <input type="text" name="mediItemName" class="form-control-sm chartlog" style="width:100%;" id="mediItemName2">
				            </div>
				            <div class="mb-3">
				              <label class="form-label chartloglabel"><strong>수납금</strong></label><br>
				              <input type="text" name="rcivPayment" class="form-control-sm chartlog" id="rcivPayment2">
				            </div>
				      </div>
     			 </div>`;
				//////////////////////////////////날짜로 검색한 차트 끝////////////////////////////////////////////////////  

				var gr4 = `
							<div class="card-body">
							<div style="display: flex;">
								<div>
						        	<h5 class="pb-2 border-bottom mb-4" style="text-align:left; margin-right:120px; font-weight: bold; width: 75px;">진료차트</h5>
						        </div>
						        <div> 
						        	<button type="button" class="btn btn-primary me-3" onclick="endClinic()" style="margin-left: 545px;">진료완료</button> 
						        </div>
					    	</div> 
					    
				       		<div class="mb-3">
						        <label class="form-label"><strong>차트번호</strong></label>
						        <input type="text" name="detailNo" class="form-control-sm" id="detailNo2" style="width:12%; margin:0px;">
						        <label class="form-label"><strong>진료번호</strong></label>
						        <input type="text" name="treatNo" class="form-control-sm" id="treatNo" style="width:12%; margin:0px;">
						        
						        <label class="form-label"><strong>환자유형</strong></label>
						        <input type="text" name="patType" class="form-control-sm" id="patType" style="width:20%; margin:0px;">		  
						        <input type="hidden" name="hidePatHspt" class="form-control-sm" id="hidePatHspt">		  
						        <input type="hidden" name="hideHspOutPlan" class="form-control-sm" id="hideHspOutPlan">		  
				   		 	</div> 
				    
				   		<div id="one" style="display: flex; align-items: flex-start;"> 
					   	    <div style="display: flex;">
					   	        <label class="form-label" style="margin-right: 10px;"><strong>증상메모</strong></label>
					   	        <textarea class="form-control" id="detailMemo1" rows="2"  style="width: 263px;"></textarea>
					   	    </div>
				 
					   	    <div style="text-align: left; align-items: center; margin-top: 7px; margin-right: 15px; margin-left: 67px;"> 
					   	        <label class="form-label" id="hsptYN"><strong>입원여부</strong></label> 
					   	        <input class="form-check-input" type="checkbox" name="patHsptlzStatus" id="patHsptlzStatusIn"><br>
					   	     	<label class="form-label"><strong>잔여병상</strong></label> 
					   	        <input class="form-control-sm" style="width:40px;" type="text" name="bedCnt" id="bedCnt">
					   	    </div> 
					  
					   	    <div style="text-align: center; align-items: center; margin-top: 8px;">
					   	        <label class="form-label"><strong>퇴원여부</strong></label> 
					   	        <input class="form-check-input" type="checkbox" name="patHsptlzStatus" id="patHsptlzStatusOut">
					   	    </div> 
					 
					   	    <div style="text-align: center; align-items: center; margin-top: 7px; margin-left: 33px;">
					   	        <label class="form-label"><strong>퇴원예정일</strong></label>
					   	        <input class="form-control-sm" type="date" name="patHsptlzOutPlan" id="patHsptlzOutPlan" style="width: 150px; border:1px solid #d9dee3;">
					   	    </div>                        
				   		</div> 
				               
				        <div style="display:flex; margin-top: 10px;">
							<div>
					        <h5 class="pb-2 border-bottom mb-4" style="text-align:left; display:inline; font-weight: bold; margin:20px; ">질병</h5>
					        </div>
					        <div>
					      	  <button type="button" class="btn btn-primary me-3" onclick="showDiss()">추가</button>
					        </div>
				        </div>
				        
				        <div id="dissOrder" style="height:11vw;">       
				      		 <div class="card-body">         		
				         		 <table class="table table-hover">
							         <thead> 
								         <tr>
									         <th>질병 코드</th>
									         <th>질병 국문명</th>
									         <th>질병 영문명</th>
								         </tr>
							         </thead>
							         <tbody>
								         <tr style="height:40px;">
									         <td></td>
									         <td></td>
									         <td></td>
								         </tr>
							         </tbody>
						         </table>	         
				        	 </div>	         
				        </div> 
     						`;

				var gr5 = `
      		<div class="nav-align-top mb-4">
    	        <ul class="nav nav-tabs" role="tablist">
		              <li class="nav-item" role="presentation">
		                <button type="button" class="nav-link active" role="tab" data-bs-toggle="tab" data-bs-target="#inspcection" aria-controls="inspcection" aria-selected="true">검사</button>
		              </li>
		              <li class="nav-item" role="presentation">
		                <button type="button" class="nav-link" role="tab" data-bs-toggle="tab" data-bs-target="#physiotherapy" aria-controls="physiotherapy" aria-selected="false" tabindex="-1">치료</button>
		              </li>
		              <li class="nav-item" role="presentation">
		                <button type="button" class="nav-link" role="tab" data-bs-toggle="tab" data-bs-target="#treatment" aria-controls="inspcection" aria-selected="false" tabindex="-1">처치</button>
		              </li>
		              <li class="nav-item" role="presentation">
		              	<button type="button" class="nav-link" role="tab" data-bs-toggle="tab" data-bs-target="#prescription" aria-controls="#prescription" aria-selected="false" tabindex="-1">처방</button>
		              </li>
		           	<h6 class="pb-2 border-bottom mb-4" style="text-align:left; display:inline; font-weight: bold; margin:13px; ">그룹오더</h6>

		               <input type="text" name="dissCodeNo" class="form-control-sm" id="grpOrd" style="width:12%; margin:0px;">
		               <button type="button" class="btn btn-info me-3" onclick="showGrpOrd()">조회</button> 
             	</ul>
            <div class="tab-content">
              <div class="tab-pane fade show active" id="inspcection" role="tabpanel">
		      	<div style="display:flex; margin:10px;">
		    		<div>
		           	   <h5 class="pb-2 border-bottom mb-4" style="text-align:left; display:inline; font-weight: bold; margin:20px; ">검사</h5>
		            </div>
		            
		            <div>
			           <button type="button" class="btn btn-primary " onclick="showInspc()">추가</button>
			           <button type="button" class="btn btn-info me-3" onclick="plzInspc()">요청</button>

			          
		            </div>
		        </div>
		        
		            <div id="inspcOrder" style="height:13vw;">
				       	 <div class="card-body">
					         <table class="table table-hover">
						         <thead> 
							         <tr>
								         <th>검사 코드</th>
								         <th>검사 내용</th>
								         <th>검사 비용</th>
								         <th>검사 결과</th>
							         </tr>
							     </thead>
							     <tbody>
							         <tr style="height:40px;">
								         <td></td>
								         <td></td>
								         <td></td>
								         <td></td>
							         </tr>
						         </tbody>
					         </table>
					         <textarea class="form-control" id="inspcMemo" name="inspcMemo" rows="2" style="width:100%;" placeholder="검사메모를 작성해주세요."></textarea>
				         </div>		            
		            </div>
              </div>
              
            
           		   
              <div class="tab-pane fade" id="physiotherapy" role="tabpanel">
	              <div style="display:flex; margin:10px;">
	      			<div>
	              		<h5 class="pb-2 border-bottom mb-4" style="text-align:left; display:inline; font-weight: bold; margin:20px; ">물리치료</h5>
	              	</div>
	              <div>
		              <button type="button" class="btn btn-primary" onclick="showPhysio()">추가</button>
		              <button type="button" class="btn btn-info me-3" onclick="plzPhysio()">요청</button>
	              </div>
	             </div>
	              <div id="physioOrder" style="height:13vw;">
				       	 <div class="card-body">
					         <table class="table table-hover">
						         <thead> 
							         <tr>
								         <th>치료 코드</th>
								         <th>치료 내용</th>
								         <th>치료 비용</th>
							         </tr>
							     </thead>
							     <tbody>
							         <tr style="height:40px;">
								         <td></td>
								         <td></td>
								         <td></td>
							         </tr>
						         </tbody>
					         </table>			          
				         </div>	
	              </div>
              </div>
              
              
              <div class="tab-pane fade" id="treatment" role="tabpanel">
	      		<div style="display:flex; margin:10px;">
		    		<div>
		            	<h5 class="pb-2 border-bottom mb-4" style="text-align:left; display:inline; font-weight: bold; margin:20px; ">처치</h5>
		            </div>
		            <div>
			            <button type="button" class="btn btn-primary" onclick="showTreat()">추가</button>
			            <button type="button" class="btn btn-info me-3" onclick="plzTreat()">요청</button>
		            </div>
		        </div>
		        <div id="treatOrder" style="height:13vw;">
			       	 <div class="card-body">
				         <table class="table table-hover">
					         <thead> 
						         <tr>
							         <th>처치 코드</th>
							         <th>처치 내용</th>
							         <th>처치 비용</th>	
						         </tr>
						     </thead>
						     <tbody>
						         <tr style="height:40px;">
							         <td></td>
							         <td></td>
							         <td></td>
						         </tr>
					         </tbody>
				         </table>
				         <textarea class="form-control" id="treMemo" name="treMemo" rows="2" style="width:100%;" placeholder="처치메모를 작성해주세요."></textarea>
			        </div>		            
	            </div>            
            </div>
            
            
              <div class="tab-pane fade" id="prescription" role="tabpanel">
		         <div style="display:flex; margin:10px;">
		      		<div>
		              <h5 class="pb-2 border-bottom mb-4" style="text-align:left; display:inline; font-weight: bold; margin:20px; ">처방</h5>
		            </div>
		            <div>
		              <button type="button" class="btn btn-primary" onclick="showMedi()">추가</button>
		              <button type="button" class="btn btn-info me-3" onclick="plzMedi()">요청</button>
		            </div>
		         </div>
		              <div id="mediOrder" style="height:13vw;">
				       	 <div class="card-body">
					         <table class="table table-hover" id="mediTable">
						         <thead> 
							         <tr>
								         <th>약품 코드</th>
								         <th>약품명</th>
								         <th>투약량</th>
									     <th>투약횟수</th>
									     <th>투약일수</th>
							         </tr>
							     </thead>
							     <tbody>
							         <tr style="height:40px;">
								         <td></td>
								         <td></td>
								         <td></td>
							   		     <td></td>
									     <td></td>
							         </tr>
						         </tbody>
					         </table>
				         </div>		            
			            </div>
		             </div>
        	 </div>
            </div>
          </div>      	
      	`;

				var items = [
					{ w: 2, h: 5, x: 0, y: 0, content: gr1 },
					{ w: 4, h: 2, x: 2, y: 0, content: gr2 },
					{ w: 4, h: 3, x: 2, y: 3, content: gr3 },
					{ w: 6, h: 2.5, x: 6, y: 0, content: gr4 },
					{ w: 6, h: 3.5, x: 6, y: 2.5, content: gr5 },
				];

				var grid = GridStack.init();
				grid.load(items);

				// WAIT상태의 환자 호출 시에만 차트번호 생성, 진료번호 생성, CING로 상태 변경하기!!(매퍼 수정)


				// 환자 정보 조회 - 호출버튼 눌렀을때
				function patInfo(patCode, rceptNo, treatNo, patFirst, patDay, buttonText) {

					allClear(); // 비우기 함수

// 					console.log("patCode", patCode);
// 					console.log("rceptNo", rceptNo);
// 					console.log("treatNo", treatNo);
// 					console.log("patFirst", patFirst);
// 					console.log("patDay", patDay);

					$("#rceptNo0").val(rceptNo); // 접수번호 히든input에 저장 (접수상세보기에 쓰임)

					// 가져온 텍스트를 콘솔에 출력합니다.
					//console.log("클릭된 버튼 텍스트:", buttonText);

					if (buttonText == '호출') { // 대기상태의 환자 호출 시에만 차트번호 생성, 진료번호 생성
						console.log("callPat이 호출일때!");
						// 차트 틀 생성
						// 차트번호 생성과 동시에 차트 틀 생성 (detailNo 전달을 위해 콜백함수 사용)
						getDetailNo(function (detailNo) {
							console.log("차트번호히히콩", detailNo);
							chartBefore(detailNo, treatNo);
						});

						$("#treatNo").val(treatNo); // 진료번호 끌어오기
						console.log("rceptNo", rceptNo);

					} else if (buttonText != '호출') {
						console.log("callPat이 호출이 아닐때!");
						// 진료번호, 차트번호 출력 함수					
						getChtNoByRceptNo();
					} else {
						alert("문제가있어용");
					}


					let xhr = new XMLHttpRequest();
					let schURL = "/doctor/clinic/" + treatNo + "/" + patCode;
					//console.log(schURL);
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4 && xhr.status == 200) {
							//console.log("성공!");
							let patientVO = xhr.responseText;
							if (patientVO) {
								patientVO = JSON.parse(patientVO); //json문자열을 json객체로
								console.log(patientVO);

								$("#patCode0").val(patientVO.patCode);
								//	$("#patName0").val(patientVO.patName);
								$("#patTel0").val(patientVO.patTel);
								//             	$("#patGenCode0").val(patientVO.patGenCode);
								//             	$("#patAge0").val(patientVO.patBrthdy);

								if (patientVO.patFrgnrYn = '부') {
									var frgnrYn = '내국인';
								} else {
									var frgnrYn = '외국인';
								}

								var patName = patientVO.patName;
								var genCode = patientVO.patGenCode;
								var Brthdy = patientVO.patBrthdy;
								var patHsptlzStatus = patientVO.patHsptlzStatus;

								// 테스트 | 19980813 | 여 | 내국인 | 외래
								var test = patName + " " + "|" + " " + Brthdy + " " + "|" + " " + genCode + " " + "|" + " " + frgnrYn + " " + "|" + " " + patHsptlzStatus;
								$("#patName0").val(test);


								//             	    var patCode = patientVO.patCode;
								// 					var patHsptlzStatus = patientVO.patHsptlzStatus;

								// 					var test2 = patCode + " " + "(" + patHsptlzStatus + ")";
								// 					$("#patCode0").val(test2);


								var patAddr = patientVO.patAddr;
								var patDtlAddr = patientVO.patDtlAddr;
								var patZip = patientVO.patZip;

								// 대전 서구 만년로35 108동 (35201)
								var Addr = patAddr + " " + patDtlAddr + " " + " (" + patZip + ")";
								$("#patAddr0").val(Addr);

								//              	const birthdate = patientVO.patBrthdy; // patBrthdy.value는 "19980813" 형식으로 가정
								//              	console.log(birthdate);

								//              	const currentDate = new Date(); // 현재 날짜
								//              	const age = currentDate.getFullYear() - birthdate.substring(0, 4); // 현재 년도 - 1998
								//              	// 계산된 나이를 patAge에 설정
								//              	$("#patAge0").val(age);

								$("#patFirstDate0").val(patientVO.patFirstDate);
								$("#patLastDate0").val(patientVO.patLastDate);
								//뽑아온 퇴원예정일
								$("#hideHspOutPlan").val(patientVO.patHsptlzOutPlan);

								//console.log("hideHspOutPlan", $("#hideHspOutPlan").val());

								//퇴원예정일 불러오기
								$("#patHsptlzOutPlan").val($("#hideHspOutPlan").val());

								// 초진 | 외래 | 주간
								let patType = patFirst + " | " + patDay + " | " + patientVO.patHsptlzStatus;

								$("#patType").val(patType);
								$("#hidePatHspt").val(patientVO.patHsptlzStatus);

								//console.log("hidePatHspt",$("#hidePatHspt").val());

								//console.log("왔어용?",$("#hidePatHspt").val());
								if ($("#hidePatHspt").val() == '입원완료') {
									//console.log("왔어용");
									$("#hsptYN strong").text("입원중");
									$("#patHsptlzStatusIn").prop("disabled", true);
								}

								//$("#patFrgnrYn0").val(patientVO.patFrgnrYn);
								//	$("#patHsptlzStatus0").val(patientVO.patHsptlzStatus);

								getDate(); // 차트 등록날짜 조회

								getWaitPat();
								// 							    if (disp.innerHTML.trim() === "") {
								// 							        alert("이 div는 비어있습니다.");
								// 							    }

								//firstPat.show();									

								let patCode = patientVO.patCode;

								// 웹소켓으로 환자호출을 연락!
								let msg = {
									to: "원무과",
									from: "의사",
									cmd: "callPat",
									data: patCode
								}
								webSocket.send(JSON.stringify(msg));

								console.log(msg, "보냈는뎅");
							} else {
								alert("환자 호출 오류.");
							}

							//잔여병상처리, 잔여병상 출력이 완료된 후에 체크박스 비활성화!
							cntEmptBed(function () {

								if ($("#bedCnt").val() == 0) {
									console.log("bedCnt val", $("#bedCnt").val());
									$("#bedCnt").css("color", "red");
									// 체크박스 비활성화
									$("#patHsptlzStatusIn").prop("disabled", true);
									$("#patHsptlzStatusOut").prop("disabled", true);
									$("#patHsptlzOutPlan").prop("disabled", true);

								}
							});
						}
					}
					xhr.send();
				}//end patInfo()



				// 환자접수상세조회	
				function recDetail() {
					detailModal.style.display = "block";
					//console.log("조회버튼 체킁");
					console.log("접수번호", $("#rceptNo0").val());
					let rceptNo = $("#rceptNo0").val();

					let schURL = "/doctor/clinic/receipt/" + rceptNo;
					//console.log("schURL" + schURL);
					let xhr = new XMLHttpRequest();
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4 && xhr.status == 200) {
							//console.log("성공!");
							//console.log(rceptNo);
							let patientRecieptVO = xhr.responseText;
							//console.log(xhr.responseText);
							if (patientRecieptVO) {
								patientRecieptVO = JSON.parse(patientRecieptVO); //json문자열을 json객체로

								$("#patCode1").val(patientRecieptVO.patCode);
								$("#patName1").val(patientRecieptVO.patName);
								$("#patBrthdy1").val(patientRecieptVO.patBrthdy);

								const birthdate = $("#patBrthdy1").val(); // patBrthdy.value는 "19980813" 형식으로 가정
								//console.log(birthdate);

								const currentDate = new Date(); // 현재 날짜
								const age = currentDate.getFullYear() - birthdate.substring(0, 4); // 현재 년도 - 1998
								// 계산된 나이를 patAge에 설정
								$("#patAge1").val(age);
								// console.log(age);

								//let patType = patientRecieptVO.rceptFirstExamCode + " | " + patientRecieptVO.patHsptlzStatus + " | " + patientRecieptVO.rceptDayCode;
								//$("input[name='patGenCode']").val(patientRecieptVO.patGenCode);
								$("#patGenCode1").val(patientRecieptVO.patGenCode);
								$("#rceptFirstExamCode1").val(patientRecieptVO.rceptFirstExamCode);
								$("#patHsptlzStatus1").val(patientRecieptVO.patHsptlzStatus);
								$("#rceptDayCode1").val(patientRecieptVO.rceptDayCode);
								$("#patBrthdy1").val(patientRecieptVO.patBrthdy);
								$("#receptTime1").val(patientRecieptVO.receptTime);
								$("#rceptNo1").val(patientRecieptVO.rceptNo);
								$("#rceptMemo1").val(patientRecieptVO.rceptMemo);
								//$("#patType").val(patType);


								let frmRecDet = $("#frmRecDet1").serialize();
								//console.log("frmRecDet : " + frmRecDet);
							} else {
								alert("해당 환자코드는 없습니다.");
							}
						}
					}
					xhr.send();
				}//end recDetail()


				var detailModal = document.querySelector("#detailModal");
				var inspcModal = document.querySelector("#inspcModal");
				var physioModal = document.querySelector("#physioModal");
				const patCode = document.querySelector("#patCode0"); // 환자코드
				const inspcType = document.querySelector("#inspcType"); // 검사부위
				const treContent = document.querySelector("#treContent"); // 처치내용
				const detailNo = document.querySelector("#detailNo2"); //차트번호
				const treatNo = document.querySelector("#treatNo"); //진료번호
				const inspcMemo = document.querySelector("#inspcMemo"); //검사메모
				const dissCodeNo = document.querySelector("#grpOrd"); //질병코드번호
				const waitTotal = $('#waitTotal');  //대기환자목록
				const waitTBody = $('#waitTBody');  //대기환자목록
				const dateList = document.querySelector("#disp"); // 차트 등록날짜 출력
				const inspcList = document.querySelector("#inspcList"); // 검사 리스트 모달창
				const grpOrdList = document.querySelector("#grpOrdList"); // 그룸오더 출력
				const itable = $(".itable");


				//날짜 뿌리기
				function getDate() {
					let xhr = new XMLHttpRequest();
					let schURL = `/doctor/clinic/date/\${patCode.value}`
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = () => {
						if (xhr.readyState == 4 && xhr.status == 200) {
							console.log("날짜도착");
							//json문자열을 json객체로 바꿔야 편하게 쓸 수 있음
							let rslt = JSON.parse(xhr.responseText)
							let tblStr = `<div class="card-body">`;
							// tblStr += `<h5 class="pb-2 border-bottom mb-4"  style="font-weight: bold;">진료내역</h5>`;

							for (let i = 0; i < rslt.length; i++) {
								tblStr += `<button type="button" id="dateBtn" class="btn btn-outline-primary" style="width:111px;" onclick="showChart('\${rslt[i].detailRegDate}','\${rslt[i].treatNo}')">\${rslt[i].detailRegDate}</button><br>`;
							}
							tblStr += "</div>"
							dateList.innerHTML = tblStr;

							const rsltL = rslt.length;
							console.log("rslt.length", rslt.length);

							if (rsltL == 0) { // 첫 내원 환자일 경우
								//    alert("이 div는 비어있습니다.");
								firstPat.style.display = "block";
								dateList.style.display = "none";
								//  $("#dateBtn").css("display", "none");
							} else {
								firstPat.style.display = "none";
								dateList.style.display = "block";
								//	$("#dateBtn").css("display", "block");
							}
						}
					}
					xhr.send();
				}



				// 등록날짜로 검색한 환자차트!
				function showChart(detailRegDate, treatNo) {
					//console.log("차트보깅 체킁");
					//const detailRegDate = $(button).text();
					console.log("detailRegDate보깅", detailRegDate);
					let patCode = $("#patCode0").val();
					console.log("treatNo보깅", treatNo);
					//let treatNo = $("#treatNo").val();
					console.log("patCode보깅", patCode);
					//console.log("treatNo보깅", treatNo);

					let schURL = "/doctor/clinic/date/chart/" + detailRegDate + "/" + patCode + "/" + treatNo;
					console.log("schURL보깅", schURL);
					let xhr = new XMLHttpRequest();
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4 && xhr.status == 200) {
							//console.log("성공!");
							let chartDetailByDateVOList = xhr.responseText;
							// let chartDetailByDateVO = xhr.responseText;
							console.log(xhr.responseText);
							if (chartDetailByDateVOList) {
								//chartDetailByDateVO = JSON.parse(chartDetailByDateVO); //json문자열을 json객체로
								chartDetailByDateVOList = JSON.parse(chartDetailByDateVOList); //json문자열을 json객체로

								//console.log("하잉하이", chartDetailByDateVOList);
								//  console.log("하잉하이 바바",chartDetailByDateVOList[0].inspcType); // 두부 머리촬영
								let inspcType2 = [];
								let treContent2 = [];
								let physioContent2 = [];
								let mediItemName2 = [];

								//console.log("길이예용", chartDetailByDateVOList.length);
								//   console.log("0번째",chartDetailByDateVOList[0].inspcType);
								//console.log("1번째", chartDetailByDateVOList[1].inspcType);

								//             		for(let i = 0; i < chartDetailByDateVOList.length; i++){
								//             				if(i == chartDetailByDateVOList.length-1){         					
								//             					inspcType2 += chartDetailByDateVOList[i].inspcType;
								//             					treContent2 += chartDetailByDateVOList[i].treContent;
								//             					physioContent2 += chartDetailByDateVOList[i].physioContent;
								//             					mediItemName2 += chartDetailByDateVOList[i].mediItemName;
								//             					//dissKorName += chartDetailByDateVOList[i].dissKorName;
								//             				}else{
								//             					inspcType2 += chartDetailByDateVOList[i].inspcType + ",";
								//             					treContent2 += chartDetailByDateVOList[i].treContent + ",";
								//             					physioContent2 += chartDetailByDateVOList[i].physioContent + ",";
								//             					mediItemName2 += chartDetailByDateVOList[i].mediItemName + ",";
								//             				}
								//             		}	
								for (let i = 0; i < chartDetailByDateVOList.length; i++) {

									let inspcTypeData = chartDetailByDateVOList[i].inspcType;
									let treContentData = chartDetailByDateVOList[i].treContent;
									let physioContentData = chartDetailByDateVOList[i].physioContent;
									let mediItemNameData = chartDetailByDateVOList[i].mediItemName;

									let inspcTypeindex = inspcType2.indexOf(inspcTypeData);
									let treContentindex = treContent2.indexOf(treContentData);
									let physioContentindex = physioContent2.indexOf(physioContentData);
									let mediItemNameindex = mediItemName2.indexOf(mediItemNameData);

									if (inspcTypeindex == -1) {
										inspcType2.push(inspcTypeData)
									}

									if (treContentindex == -1) {
										treContent2.push(treContentData)
									}

									if (physioContentindex == -1) {
										physioContent2.push(physioContentData)
									}

									if (mediItemNameindex == -1) {
										mediItemName2.push(mediItemNameData)
									}
								}
								//console.log(inspcType2);
								$("#rceptFirstExamCode2").val(chartDetailByDateVOList[0].rceptFirstExamCode);
								$("#rceptDayCode2").val(chartDetailByDateVOList[0].rceptDayCode);
								$("#patHsptlzStatus2").val(chartDetailByDateVOList[0].patHsptlzStatus);
								$("#detailMemo2").val(chartDetailByDateVOList[0].detailMemo);
								$("#dissKorName2").val(chartDetailByDateVOList[0].dissKorName);
								$("#inspcType2").val(inspcType2);
								$("#treContent2").val(treContent2);
								$("#physioContent2").val(physioContent2);
								$("#mediItemName2").val(mediItemName2);

								// 천 단위 ,찍기
								let rcivPayment = chartDetailByDateVOList[0].rcivPayment.toLocaleString();
								$("#rcivPayment2").val(rcivPayment);

							}
						} // readyState의 끝
					} //  xhr.onreadystatechange의 끝
					xhr.send();
				}// showChart end 


				//차트번호 출력
				function getDetailNo(callback) {
					let xhr = new XMLHttpRequest();
					let schURL = "/doctor/clinic/chart/detailNo";
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4 && xhr.status == 200) {
							console.log("차트번호도착")
							let chartDetailVO = xhr.responseText;
							console.log("차트번호결과는?" + xhr.responseText);
							if (chartDetailVO) {
								chartDetailVO = JSON.parse(chartDetailVO); //json문자열을 json객체로
								$("#detailNo2").val(chartDetailVO.detailNo);
								console.log("차트번호출력이에용!", chartDetailVO.detailNo);
								console.log("차트번호출력이에용!", $("#detailNo2").val());
								// 콜백 함수 호출
								callback(chartDetailVO.detailNo);
							}
						}
					}
					xhr.send();
				}

				// //진료번호 출력
				// function getTreatNo() {
				//     let xhr = new XMLHttpRequest();
				//     let schURL = "/doctor/clinic/chart/treatNo";
				//     xhr.open("get",schURL,true);
				//     xhr.onreadystatechange = function(){
				//         if(xhr.readyState == 4 && xhr.status == 200){
				//         	console.log("진료번호도착")
				//         	let clinicVO = xhr.responseText;
				//         	console.log("진료번호결과는?"+xhr.responseText);
				//         	if(clinicVO){
				//         		clinicVO = JSON.parse(clinicVO); //json문자열을 json객체로
				//         		$("#treatNo").val(clinicVO.treatNo);        	
				//         }
				//     }
				//     }
				//     xhr.send(); 
				// }

				//검사오더검색창	
				function showInspc() {
					inspcModal.style.display = "block";
					getInspc();
				}//end showInspc()





				//처치오더검색창	
				function showTreat() {
					treatModal.style.display = "block";
					getTreat();
				}//end showTreat()


				//치료오더검색창	
				function showPhysio() {
					physioModal.style.display = "block";
					getPhysio();
				}//end showPhysio()


				//질병검색창	
				function showDiss() {
					dissModal.style.display = "block";
					getDiss();
				}//end showDiss()

				//처방검색창	
				function showMedi() {
					mediModal.style.display = "block";
					getMedi();
				}//end showMedi()

				// 검사 조회하기
				function getInspc() {

					let xhr = new XMLHttpRequest();
					let schURL = `/doctor/clinic/chart/order/inspc`
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = () => {
						if (xhr.readyState == 4 && xhr.status == 200) {
							console.log("검사조회하기");

							// JSON 문자열을 JSON 객체로 바꿔야 편하게 쓸 수 있음
							let rslt = JSON.parse(xhr.responseText);
							console.log(rslt);
							let tblInspc = `<div class="card-body" style="padding: 1.0rem 1.5rem 0rem;">`;
							tblInspc += `<table class="table table-hover">`;
							tblInspc += `<thead>`;
							tblInspc += `<tr id="tr1">`;
							tblInspc += `<th id="th1">선택</th>`;
							tblInspc += `<th id="th2">검사 코드</th>`;
							tblInspc += `<th id="th4">검사 내용</th>`;
							tblInspc += `<th id="th3">검사 비용</th>`;
							tblInspc += `</tr>`;
							tblInspc += `</thead>`;
							tblInspc += `<tbody class="table-border-bottom-0">`;
							for (let i = 0; i < rslt.length; i++) {
								tblInspc += `<tr>`;
								tblInspc += `<td><input type="checkbox" name="check"><label for="check"></label></td>`;
								tblInspc += `<td>\${rslt[i].inspcCode}</td>`;
								tblInspc += `<td>\${rslt[i].inspcType}</td>`;
								tblInspc += `<td>\${rslt[i].inspcCost.toLocaleString()}</td>`;
								tblInspc += `</tr>`;
							}
							tblInspc += `</tbody>`;
							tblInspc += `</table>`;
							tblInspc += `</div>`;
							inspcList.innerHTML = tblInspc;
						}
					}
					xhr.send();
				}

				// 검사 검색하기
				function searchInspc() {
					console.log("검색버튼눌렸당");
					console.log("검사부위" + inspcType.value);

					let xhr = new XMLHttpRequest();
					let schURL = `/doctor/clinic/chart/order/inspc/\${inspcType.value}`
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = () => {
						if (xhr.readyState == 4 && xhr.status == 200) {
							console.log("검사부위 도착");

							// JSON 문자열을 JSON 객체로 바꿔야 편하게 쓸 수 있음
							let rslt = JSON.parse(xhr.responseText);
							console.log(rslt);
							let tblInspc = `<div class="card-body" style="padding: 1.0rem 1.5rem 0rem;">`;
							tblInspc += `<table class="table table-hover">`;
							tblInspc += `<thead>`;
							tblInspc += `<tr id="tr1">`;
							tblInspc += `<th id="th1">선택</th>`;
							tblInspc += `<th id="th2">검사 코드</th>`;
							tblInspc += `<th id="th4">검사 내용</th>`;
							tblInspc += `<th id="th3">검사 비용</th>`;
							tblInspc += `</tr>`;
							tblInspc += `</thead>`;
							tblInspc += `<tbody class="table-border-bottom-0">`;
							for (let i = 0; i < rslt.length; i++) {
								tblInspc += `<tr>`;
								tblInspc += `<td><input type="checkbox" name="check"><label for="check"></label></td>`;
								tblInspc += `<td>\${rslt[i].inspcCode}</td>`;
								tblInspc += `<td>\${rslt[i].inspcType}</td>`;
								tblInspc += `<td>\${rslt[i].inspcCost.toLocaleString()}</td>`;
								tblInspc += `</tr>`;
							}
							tblInspc += `</tbody>`;
							tblInspc += `</table>`;
							tblInspc += `</div>`;
							inspcList.innerHTML = tblInspc;
						}
					}
					xhr.send();
				}


				//처치 조회하기
				function getTreat() {

					let xhr = new XMLHttpRequest();
					let schURL = `/doctor/clinic/chart/order/treat`
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = () => {
						if (xhr.readyState == 4 && xhr.status == 200) {

							// JSON 문자열을 JSON 객체로 바꿔야 편하게 쓸 수 있음
							let rslt = JSON.parse(xhr.responseText);
							console.log(rslt);
							let tblInspc = `<div class="card-body" style="padding: 1.0rem 1.5rem 0rem;">`;
							tblInspc += `<table class="table table-hover">`;
							tblInspc += `<thead>`;
							tblInspc += `<tr id="tr1">`;
							tblInspc += `<th id="th1">선택</th>`;
							tblInspc += `<th id="th2">처치 코드</th>`;
							tblInspc += `<th id="th4">처치 내용</th>`;
							tblInspc += `<th id="th3">처치 비용</th>`;
							tblInspc += `</tr>`;
							tblInspc += `</thead>`;
							tblInspc += `<tbody class="table-border-bottom-0">`;
							for (let i = 0; i < rslt.length; i++) {
								tblInspc += `<tr>`;
								tblInspc += `<td><input type="checkbox" name="checkT"><label for="check"></label></td>`;
								tblInspc += `<td>\${rslt[i].treCode}</td>`;
								tblInspc += `<td>\${rslt[i].treContent}</td>`;
								tblInspc += `<td>\${rslt[i].treCosts.toLocaleString()}</td>`;
								tblInspc += `</tr>`;
							}
							tblInspc += `</tbody>`;
							tblInspc += `</table>`;
							tblInspc += `</div>`;
							treatList.innerHTML = tblInspc;
						}
					}
					xhr.send();
				}


				//처치 검색하기
				function searchTreat() {
					console.log("처치버튼눌렸당");
					console.log("처치내용" + treContent.value);

					let xhr = new XMLHttpRequest();
					let schURL = `/doctor/clinic/chart/order/treat/\${treContent.value}`
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = () => {
						if (xhr.readyState == 4 && xhr.status == 200) {
							console.log("처치내용 도착");

							// JSON 문자열을 JSON 객체로 바꿔야 편하게 쓸 수 있음
							let rslt = JSON.parse(xhr.responseText);
							console.log(rslt);
							let tblInspc = `<div class="card-body" style="padding: 1.0rem 1.5rem 0rem;">`;
							tblInspc += `<table class="table table-hover">`;
							tblInspc += `<thead>`;
							tblInspc += `<tr id="tr1">`;
							tblInspc += `<th id="th1">선택</th>`;
							tblInspc += `<th id="th2">처치 코드</th>`;
							tblInspc += `<th id="th4">처치 내용</th>`;
							tblInspc += `<th id="th3">처치 비용</th>`;
							tblInspc += `</tr>`;
							tblInspc += `</thead>`;
							tblInspc += `<tbody class="table-border-bottom-0">`;
							for (let i = 0; i < rslt.length; i++) {
								tblInspc += `<tr>`;
								tblInspc += `<td><input type="checkbox" name="checkT"><label for="check"></label></td>`;
								tblInspc += `<td>\${rslt[i].treCode}</td>`;
								tblInspc += `<td>\${rslt[i].treContent}</td>`;
								tblInspc += `<td>\${rslt[i].treCosts.toLocaleString()}</td>`;
								tblInspc += `</tr>`;
							}
							tblInspc += `</tbody>`;
							tblInspc += `</table>`;
							tblInspc += `</div>`;
							treatList.innerHTML = tblInspc;
						}
					}
					xhr.send();
				}


				//치료 조회하기
				function getPhysio() {

					let xhr = new XMLHttpRequest();
					let schURL = `/doctor/clinic/chart/order/physio`
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = () => {
						if (xhr.readyState == 4 && xhr.status == 200) {

							// JSON 문자열을 JSON 객체로 바꿔야 편하게 쓸 수 있음
							let rslt = JSON.parse(xhr.responseText);
							console.log(rslt);
							let tblInspc = `<div class="card-body" style="padding: 1.0rem 1.5rem 0rem;">`;
							tblInspc += `<table class="table table-hover">`;
							tblInspc += `<thead>`;
							tblInspc += `<tr id="tr1">`;
							tblInspc += `<th id="th1" style="width: 100px;">선택</th>`;
							tblInspc += `<th id="th2">치료 코드</th>`;
							tblInspc += `<th id="th4">치료 내용</th>`;
							tblInspc += `<th id="th3">치료 비용</th>`;

							tblInspc += `</tr>`;
							tblInspc += `</thead>`;
							tblInspc += `<tbody class="table-border-bottom-0">`;
							for (let i = 0; i < rslt.length; i++) {
								tblInspc += `<tr>`;
								tblInspc += `<td><input type="checkbox" name="checkP"><label for="check"></label></td>`;
								tblInspc += `<td>\${rslt[i].physioCode}</td>`;
								tblInspc += `<td>\${rslt[i].physioContent}</td>`;
								tblInspc += `<td>\${rslt[i].physioCost.toLocaleString()}</td>`;

								tblInspc += `</tr>`;
							}
							tblInspc += `</tbody>`;
							tblInspc += `</table>`;
							tblInspc += `</div>`;
							physioList.innerHTML = tblInspc;
						}
					}
					xhr.send();
				}

				//치료 검색하기
				function searchPhysio() {
					console.log("치료버튼눌렸당");
					console.log("치료내용" + physioContent.value);

					let xhr = new XMLHttpRequest();
					let schURL = `/doctor/clinic/chart/order/physio/\${physioContent.value}`
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = () => {
						if (xhr.readyState == 4 && xhr.status == 200) {
							console.log("치료내용 도착");

							// JSON 문자열을 JSON 객체로 바꿔야 편하게 쓸 수 있음
							let rslt = JSON.parse(xhr.responseText);
							console.log(rslt);
							let tblInspc = `<div class="card-body" style="padding: 1.0rem 1.5rem 0rem;">`;
							tblInspc += `<table class="table table-hover">`;
							tblInspc += `<thead>`;
							tblInspc += `<tr id="tr1">`;
							tblInspc += `<th id="th1">선택</th>`;
							tblInspc += `<th id="th2">치료 코드</th>`;
							tblInspc += `<th id="th4">치료 내용</th>`;
							tblInspc += `<th id="th3">치료 비용</th>`;

							tblInspc += `</tr>`;
							tblInspc += `</thead>`;
							tblInspc += `<tbody class="table-border-bottom-0">`;
							for (let i = 0; i < rslt.length; i++) {
								tblInspc += `<tr>`;
								tblInspc += `<td><input type="checkbox" name="checkP"><label for="check"></label></td>`;
								tblInspc += `<td>\${rslt[i].physioCode}</td>`;
								tblInspc += `<td>\${rslt[i].physioContent}</td>`;
								tblInspc += `<td>\${rslt[i].physioCost.toLocaleString()}</td>`;

								tblInspc += `</tr>`;
							}
							tblInspc += `</tbody>`;
							tblInspc += `</table>`;
							tblInspc += `</div>`;
							physioList.innerHTML = tblInspc;
						}
					}
					xhr.send();
				}


				//진료대기 목록 출력
				function getWaitPat() {

					$.ajax({
						url: `/doctor/clinic/waitList/\${empNo}`,
						type: 'get',
						dataType: 'JSON',
						success: function (result) {
							if (result.length == 0) {
								let top = "";
								top += `<h5 class='pb-2 mb-4' style='text-align:left; margin: 0px 120px -1px 0px !important; font-weight: bold;'>
									<div style="display:flex;">
										<i class='bx bxs-user-detail' style='color:#4a5b6d; font-size:2rem;' ></i>
										<p style="margin: 8px 0px 0px 6px;"><small>진료대기 환자 0명</small></p>
									</div>
									</h5>`
								waitTotal.html(top)
							} else {
								let top = "";
								top += `<h5 class='pb-2 mb-4' style='text-align:left; margin: 0px 120px -1px 0px !important; font-weight: bold;'>
								<div style="display:flex;">
									<i class='bx bxs-user-detail' style='color:#4a5b6d; font-size:2rem;' ></i>
									<p style="margin: 8px 0px 0px 6px;">진료대기 : \${result.length}명</p>
								</div>
								</h5>
								<span class="bg-label-secondary" style="font-size:1.0rem; text-align:left; margin: -15px 120px 0px 0px; padding: 5px; border-radius: 7px; color: #67707b !important;">\${result[0].hosFcName}| 담당의 : \${result[0].empNm}</span>`
								waitTotal.html(top)
								console.log("진료대기 목록 출력", result);
								let txt = "";
								for (let i = 0; i < result.length; i++) {
									let buttonText = "호출"; // 기본 버튼 텍스트
									let buttonClass = "btn btn-danger me-3"; // 기본 버튼 클래스
									console.log("result[i].patWait", result[i].patWait);
									if (result[i].patWait == '진료중') {
										buttonText = "진료중";
										buttonClass = "btn btn-primary me-3";
									} else if (result[i].patWait == '진료대기') {
										buttonText = "호출";
										buttonClass = "btn btn-danger me-3";
									} else if (result[i].patWait == '검사대기') {
										buttonText = "검사대기";
										buttonClass = "btn btn-info me-3";
									} else if (result[i].patWait == '검사중') {
										buttonText = "검사중";
										buttonClass = "btn btn-info me-3";
									} else if (result[i].patWait == '검사완료') {
										buttonText = "검사완료";
										buttonClass = "btn btn-info me-3";
									} else if (result[i].patWait == '치료대기') {
										buttonText = "치료대기";
										buttonClass = "btn btn-info me-3";
									}
									txt += ` 
								        <tr>
									        <td style="padding:1rem;">
									       		 <h5 class="mb-0"><strong>\${result[i].patName}</strong> <small>| \${result[i].patBrthdy}</small></h5>
										        <div style="display: flex; justify-content: space-between; align-items: center;">
													<div>
														<h6 class="mb-0"><small>\${result[i].patGen} | \${result[i].patFirst} | \${result[i].patHsptlzStatus} </small></h6>
													</div>
										            <div style="margin-right: 56px;">
										                <button type="button" id="callPat" class="\${buttonClass}" onclick="patInfo('\${result[i].patCode}', '\${result[i].rceptNo}', '\${result[i].treatNo}', '\${result[i].patFirst}', '\${result[i].patDay}','\${buttonText}')">\${buttonText}</button>
										            </div>
										        </div>
									   		</td>
								        </tr>
								    `;
								}
								waitTBody.html(txt);
							}
						}
					});
				};


				// 차트 틀 작성
				function chartBefore(detailNo, treatNo) {

					getWaitPat(); // 환자대기목록

					console.log("차트번호" + detailNo);
					console.log("진료번호" + treatNo);
					//넘겨야 할 data
					let chartDetailVO = {
						detailNo: detailNo,
						treatNo: treatNo
					}

					let xhr = new XMLHttpRequest();
					xhr.open("post", "/doctor/clinic/chart/before", true);
					xhr.setRequestHeader("Content-Type", "application/json;charset=utf-8");
					//여기는 json문자열이 들어있어용
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4 && xhr.status == 200) {
							if (xhr.responseText) {
								Swal.fire({
									icon: 'success',
									title: '환자 호출'
								});
							} else {
								alert("뭔가 잘못되었어용");
							}
							console.log("차트 insert체킁", xhr.responseText); // 성공시 1이 찍힌당          
						}
					}
					xhr.send(JSON.stringify(chartDetailVO)); //문자열 (json형식의 문자열)
				}


				//체크한 검사가 찍히기 위한
				var inspcCodeList = [];
				var inspcCostList = [];
				var inspcTypeList = [];

				// 체크한 검사 찍히게
				function checkInspc() {
					console.log("눌렸당!");
					console.log("체크된 체크박스의 갯수: " + $("input[name=check]:checked").length);


					// 체크된 체크박스 가져오기
					var checkbox = $("input[name=check]:checked");

					// 체크된 체크박스의 값을 반복해 불러오기
					checkbox.each(function (i) {
						var tr = checkbox.parent().parent().eq(i); // checkbox의 부모는 td
						var th = tr.children(); // td의 부모는 tr

						var inspcCode = th.eq(1).text(); // th의 1번째는 검사코드
						var inspcType = th.eq(2).text(); // th의 2번째는 검사부위
						var inspcCost = th.eq(3).text(); // th의 3번째는 검사비용


						inspcCodeList.push(inspcCode);
						inspcCostList.push(inspcCost);
						inspcTypeList.push(inspcType);
					});

					console.log(inspcCodeList);
					console.log(inspcCostList);
					console.log(inspcTypeList);

					inspcModal.style.display = "none"; // 검사오더 검색창 닫깅


					let tblInspc2 = `<div class="card-body">`;
					tblInspc2 += `<table class="table table-hover">`;
					tblInspc2 += `<thead>`;
					tblInspc2 += `<tr>`;
					tblInspc2 += `<th>검사 코드</th>`;
					tblInspc2 += `<th>검사 내용</th>`;
					tblInspc2 += `<th>검사 비용</th>`;
					tblInspc2 += `</tr>`;
					tblInspc2 += `</thead>`;
					tblInspc2 += `<tbody class="table-border-bottom-0">`;
					for (let i = 0; i < inspcCodeList.length; i++) {
						tblInspc2 += `<tr>`;
						tblInspc2 += `<td>\${inspcCodeList[i]}</td>`;
						tblInspc2 += `<td>\${inspcTypeList[i]}</td>`;
						tblInspc2 += `<td>\${inspcCostList[i]}</td>`;
						tblInspc2 += `</tr>`;
					}
					tblInspc2 += `</tbody>`;
					tblInspc2 += `</table>`;
					tblInspc2 += `<textarea class="form-control" id="inspcMemo" name="inspcMemo" rows="2" style="width:100%;" placeholder="검사메모를 작성해주세요."></textarea>`
					tblInspc2 += `</div>`;
					inspcOrder.innerHTML = tblInspc2;

				}



				//검사오더요청
				function plzInspc() {

					let data = [];

					for (let i = 0; i < inspcCodeList.length; i++) {

						// 금액 천단위 콤마 제거
						let inspcCost = parseInt(inspcCostList[i].replace(/,/g, ''));
						console.log("hi", inspcCost);

						//넘겨야 할 data
						let newData = {
							inspcCode: inspcCodeList[i],
							detailNo: $("#detailNo2").val(),
							treatNo: $("#treatNo").val(),
							inspcCost: inspcCost,
							inspcMemo: $("#inspcMemo").val()
						};
						data.push(newData);
						console.log("이거당!", newData);
					}

					// 결과 확인
					console.log("이거아니당", data);
					console.log("이거아니당", $("#treatNo").val());

					let treatNo = $("#treatNo").val();
					console.log("차트번호" + $("#detailNo2").val());
					console.log("검사메모" + $("#inspcMemo").val());

					if($("#inspcMemo").val() == ''){
						Swal.fire({
							icon: 'warning',
							title: '검사 오더 불가',
							text: '검사 메모를 입력해주세요.'
						});
					}else{
					let xhr = new XMLHttpRequest();

					let schURL = `/doctor/clinic/chart/order/inspc/\${treatNo}`
					xhr.open("post", schURL, true);
					xhr.setRequestHeader("Content-Type", "application/json;charset=utf-8");
					//여기는 json문자열이 들어있어용
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4 && xhr.status == 200) {
							if (xhr.responseText == "success") {
								Swal.fire({
									icon: 'success',
									title: '오더 요청 완료',
									text: '검사 오더 요청이 완료되었습니다.'
								});

								// 웹소켓으로 일정등록을 연락!
								let msg = {
									to: "영상의학과",
									from: "의사",
									cmd: "plzInspc"
								}
								webSocket.send(JSON.stringify(msg));

								console.log(msg, "검사오더 보냈는뎅");

								getWaitPat();
							} else {
								alert("뭔가 잘못되었어용");
							}
							console.log("검사오더 insert체킁", xhr.responseText); // 성공시 1이 찍힌당          
						}
					}
					xhr.send(JSON.stringify(data)); //문자열 (json형식의 문자열)
				}
			}


				// 검사 결과 리스트
				function getEndInspcList() {
					console.log("검사 결과 리스트");

					let detailNo = $("#detailNo2").val();
					//let detailNo = '231006017';

					console.log("검사결과리스트detailNo", detailNo);

					let xhr = new XMLHttpRequest();
					let schURL = `/doctor/clinic/chart/order/inspc/end/\${detailNo}`
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = () => {
						if (xhr.readyState == 4 && xhr.status == 200) {
							console.log("검사 결과 리스트 성공");

							// JSON 문자열을 JSON 객체로 바꿔야 편하게 쓸 수 있음
							let rslt = JSON.parse(xhr.responseText);
							console.log(rslt);
							let tblInspc = `<div class="card-body">
							    <table class="table table-hover">
							        <thead>
							            <tr>
							                <th>검사 코드</th>
							                <th>검사 내용</th>
							                <th>검사 결과</th>
							            </tr>
							        </thead>
							        <tbody class="table-border-bottom-0">`;

							for (let i = 0; i < rslt.length; i++) {
								tblInspc += `
							        <tr>
							            <td>\${rslt[i].inspcCode}</td>
							            <td>\${rslt[i].inspcType}</td>
							            <td><button type="button" style="text-align:center; margin-left: 1rem;" class="btn btn-info me-3" 
									        onclick="getInspcPhotoList('\${rslt[i].inspcCode}')">조회</button></td>
							        </tr>`;
							}

							tblInspc += `
							  </tbody>
							</table>
							<textarea class="form-control" id="inspcMemo" name="inspcMemo" rows="2" style="width:100%;" placeholder="검사메모를 작성해주세요.">\${rslt[0].inspcMemo}</textarea>
							</div>`;
							inspcOrder.innerHTML = tblInspc;
						}
					}
					xhr.send();
				}

				// 검사 결과 사진 리스트 조회하기
				function getInspcPhotoList(inspcCode) {

					inspcPhotoModal.style.display = "block";

					console.log("검사 결과 리스트");

					let detailNo = $("#detailNo2").val();
					//let detailNo = '231006017';

					console.log("검사결과리스트detailNo", detailNo);
					console.log("검사결과리스트inspcCode", inspcCode);

					let xhr = new XMLHttpRequest();
					let schURL = `/doctor/clinic/chart/order/inspc/end/photo/\${detailNo}/\${inspcCode}`
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = () => {
						if (xhr.readyState == 4 && xhr.status == 200) {
							console.log("검사 결과 리스트 성공");

							// JSON 문자열을 JSON 객체로 바꿔야 편하게 쓸 수 있음
							let rslt = JSON.parse(xhr.responseText);
							console.log("검사결과리스트", rslt);

							console.log("결과리스트창 조회시 첫번째 사진이 뜨도록 전");
							// 결과리스트창 조회시 첫번째 사진이 뜨도록
							$(".target").attr("src", `/resources/upload\${rslt[0].fileWebPath}`);
							//	console.log("rslt filewebpath",rslt[0].fileWebPath);

							let fullString = rslt[0].fileCode;
							let ts = fullString.substring(0, 9);
							console.log("targetString", ts);


							let tblInspcP =
								`
								<div class="modal-header" style="padding: 0.5rem 0.5rem 0.25rem !important;">	
									<h3 class="pb-2 border-bottom mb-4" style="text-align:left; border:none !important; font-weight: bold;">검사내용:&nbsp;<span style="font-weight: normal;">\${rslt[0].inspcType}</span></h3>
								</div>
								<table class="table table-hover" style="font-size: 11px;">
			                      <thead>
			                          <tr>
			                              <th>NO.</th>
			                              <th>촬영사진</th>
			                          </tr>
			                      </thead>
			                 	`;
							for (let i = 0; i < rslt.length; i++) {
								tblInspcP += `
							        <tr>
							            <td>\${i + 1}</td>
							            <td><a onclick="xrayImg('/resources/upload\${rslt[i].fileWebPath}');">\${ts}_\${rslt[i].fileName}</a></td>
							        </tr>`;
							}

							tblInspcP += `
							        </tbody>
							    </table>
							`;


							console.log("결과리스트창 조회시 첫번째 사진이 뜨도록 후");
							$("#inspcPhotoList").html(tblInspcP);
							// 							enlargePhoto();// 돋보기함수실행
							// 							console.log("돋보기함수실행이용");
						}
					}
					xhr.send();
				}

				//해당 사진을 눌렀을때 실행됨
				function xrayImg(xPath) {
					console.log("xPath==>", xPath);  // 누른 사진의 경로
					$(".target").attr("src", xPath); // target을 누른 사진으로 변경
					//docFrame.attr("src",result.fileWebPath+"#toolbar=0");
					enlargePhoto(); // 돋보기함수실행
				}

				function enlargePhoto() { //돋보기 함수
					$(".wrap")
						.on('mousemove', magnify)
						.prepend("<div class='magnifier'></div>")
						.children('.magnifier').css({
							"background": "url('" + target.attr("src") + "') no-repeat",
							// 2
							"background-size": target.width() * zoom + "px " + target.height() * zoom + "px"
						});
				}


				// 체크한 처치가 찍히기 위한
				var treCodeList = [];
				var treCostsList = [];
				var treContentList = [];

				//체크한 처치 찍히게
				function checkTreat() {
					console.log("눌렸당!");
					console.log("체크된 체크박스의 갯수: " + $("input[name=checkT]:checked").length);

					// 체크된 체크박스 가져오기
					var checkbox = $("input[name=checkT]:checked");

					// 체크된 체크박스의 값을 반복해 불러오기
					checkbox.each(function (i) {
						var tr = checkbox.parent().parent().eq(i); // checkbox의 부모는 td
						var th = tr.children(); // td의 부모는 tr

						var treCode = th.eq(1).text(); // th의 1번째는 처치코드
						var treContent = th.eq(2).text(); // th의 2번째는 처치내용
						var treCosts = th.eq(3).text(); // th의 3번째는 처치비용

						treCodeList.push(treCode);
						treCostsList.push(treCosts);
						treContentList.push(treContent);
					});

					console.log(treCodeList);
					console.log(treCostsList);
					console.log(treContentList);

					treatModal.style.display = "none"; // 처치오더 검색창 닫깅

					let tblInspc2 = `<div class="card-body">`;
					tblInspc2 += `<table class="table table-hover">`;
					tblInspc2 += `<thead>`;
					tblInspc2 += `<tr>`;
					tblInspc2 += `<th>처치 코드</th>`;
					tblInspc2 += `<th>처치 내용</th>`;
					tblInspc2 += `<th>처치 비용</th>`;
					tblInspc2 += `</tr>`;
					tblInspc2 += `</thead>`;
					tblInspc2 += `<tbody class="table-border-bottom-0">`;
					for (let i = 0; i < treCodeList.length; i++) {
						tblInspc2 += `<tr>`;
						tblInspc2 += `<td>\${treCodeList[i]}</td>`;
						tblInspc2 += `<td>\${treContentList[i]}</td>`;
						tblInspc2 += `<td>\${treCostsList[i]}</td>`;
						tblInspc2 += `</tr>`;
					}
					tblInspc2 += `</tbody>`;
					tblInspc2 += `</table>`;
					tblInspc2 += `<textarea class="form-control" id="treMemo" name="treMemo" rows="2" style="width:100%;" placeholder="처치메모를 작성해주세요."></textarea>`;
					tblInspc2 += `</div>`;
					treatOrder.innerHTML = tblInspc2;
				}



				//처치오더요청
				function plzTreat() {

					let data = [];

					for (let i = 0; i < treCodeList.length; i++) {

						// 금액 천단위 콤마 제거
						let treCosts = parseInt(treCostsList[i].replace(/,/g, ''));
						console.log("treCosts", treCosts);

						//넘겨야 할 data
						let newData = {
							treCode: treCodeList[i],
							detailNo: $("#detailNo2").val(),
							treCosts: treCosts,
							treMemo: $("#treMemo").val()
						};
						data.push(newData);
						console.log("처치이거당!", newData);
					}

					console.log("처치메모 체킁!", $("#treMemo").val());

					if($("#treMemo").val() == ''){
						Swal.fire({
							icon: 'warning',
							title: '오더 요청 불가',
							text: '처치 메모를 입력해주세요.'
						});
					}else{
					let xhr = new XMLHttpRequest();
					xhr.open("post", "/doctor/clinic/chart/order/treat", true);
					xhr.setRequestHeader("Content-Type", "application/json;charset=utf-8");
					//여기는 json문자열이 들어있어용
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4 && xhr.status == 200) {
							if (xhr.responseText == "success") {
								Swal.fire({
									icon: 'success',
									title : '오더 요청 완료',
									text: '처치 오더 요청이 완료되었습니다.'
								});
							} else {
								alert("뭔가 잘못되었어용");
							}
							console.log("처치오더 insert체킁", xhr.responseText); // 성공시 1이 찍힌당          
						}
					}
					xhr.send(JSON.stringify(data)); //문자열 (json형식의 문자열)
				}
				}


				//체크한 치료가 찍히기 위한
				var physioCodeList = [];
				var physioCostList = [];
				var physioContentList = [];

				//체크한 치료 찍히게
				function checkPhysio() {
					console.log("치료치료 눌렸당!");
					console.log("체크된 체크박스의 갯수: " + $("input[name=checkP]:checked").length);


					// 체크된 체크박스 가져오기
					var checkbox = $("input[name=checkP]:checked");

					// 체크된 체크박스의 값을 반복해 불러오기
					checkbox.each(function (i) {
						var tr = checkbox.parent().parent().eq(i); // checkbox의 부모는 td
						var th = tr.children(); // td의 부모는 tr

						var physioCode = th.eq(1).text(); // th의 1번째는 치료코드
						var physioContent = th.eq(2).text(); // th의 3번째는 치료내용
						var physioCost = th.eq(3).text(); // th의 2번째는 치료비용

						physioCodeList.push(physioCode);
						physioCostList.push(physioCost);
						physioContentList.push(physioContent);
					});

					console.log(physioCodeList);
					console.log(physioCostList);
					console.log(physioContentList);

					physioModal.style.display = "none"; // 치료오더 검색창 닫깅

					let tblInspc2 = `<div class="card-body">`;
					tblInspc2 += `<table class="table table-hover">`;
					tblInspc2 += `<thead>`;
					tblInspc2 += `<tr>`;
					tblInspc2 += `<th>치료 코드</th>`;
					tblInspc2 += `<th>치료 내용</th>`;
					tblInspc2 += `<th>치료 비용</th>`;
					tblInspc2 += `</tr>`;
					tblInspc2 += `</thead>`;
					tblInspc2 += `<tbody class="table-border-bottom-0">`;
					for (let i = 0; i < physioCodeList.length; i++) {
						tblInspc2 += `<tr>`;
						tblInspc2 += `<td>\${physioCodeList[i]}</td>`;
						tblInspc2 += `<td>\${physioContentList[i]}</td>`;
						tblInspc2 += `<td>\${physioCostList[i]}</td>`;
						tblInspc2 += `</tr>`;
					}
					tblInspc2 += `</tbody>`;
					tblInspc2 += `</table>`;
					tblInspc2 += `</div>`;
					physioOrder.innerHTML = tblInspc2;
				}



				//치료오더요청
				function plzPhysio() {

					let data = [];

					for (let i = 0; i < physioCodeList.length; i++) {

						// 금액 천단위 콤마 제거
						let physioCost = parseInt(physioCostList[i].replace(/,/g, ''));
						console.log("physioCost", physioCost);

						//넘겨야 할 data
						let newData = {
							physioCode: physioCodeList[i],
							detailNo: $("#detailNo2").val(),
							treatNo: $("#treatNo").val(),
							physioCost: physioCost

						};
						data.push(newData);
						console.log("치료이거당!", newData);
					}

					let treatNo = $("#treatNo").val();
					let xhr = new XMLHttpRequest();
					let schURL = `/doctor/clinic/chart/order/physio/\${treatNo}`
					xhr.open("post", schURL, true);
					xhr.setRequestHeader("Content-Type", "application/json;charset=utf-8");
					//여기는 json문자열이 들어있어용
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4 && xhr.status == 200) {
							if (xhr.responseText == "success") {
								Swal.fire({
									icon: 'success',
									title: '오더 요청 완료',
									text: '치료 오더 요청이 완료되었습니다.'
								});

								// 웹소켓으로 일정등록을 연락!
								let msg = {
									to: "물리치료과",
									from: "의사",
									cmd: "plzPhysio"
								}
								webSocket.send(JSON.stringify(msg));

								console.log(msg, "치료오더 보냈는뎅");

								getWaitPat();
							} else {
								alert("치료오더 웹소켓 뭔가 잘못되었어용");
							}
							console.log("치료오더 insert체킁", xhr.responseText); // successc   
						}
					}
					xhr.send(JSON.stringify(data)); //문자열 (json형식의 문자열)
				}

				//질병 조회하기
				function getDiss() {

					let xhr = new XMLHttpRequest();
					let schURL = `/doctor/clinic/chart/order/diss`
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = () => {
						if (xhr.readyState == 4 && xhr.status == 200) {

							// JSON 문자열을 JSON 객체로 바꿔야 편하게 쓸 수 있음
							let rslt = JSON.parse(xhr.responseText);
							console.log(rslt);
							let tblInspc = `<div class="card-body" style="padding: 1.0rem 1.5rem 0rem;">`;
							tblInspc += `<table class="table table-hover">`;
							tblInspc += `<thead>`;
							tblInspc += `<tr id="tr1">`;
							tblInspc += `<th id="th1" style="width: 70px;">선택</th>`;
							tblInspc += `<th id="th2" style="width: 100px;">질병 코드</th>`;
							tblInspc += `<th id="th3">질병 국문명</th>`;
							tblInspc += `<th id="th4">질병 영문명</th>`;
							tblInspc += `</tr>`;
							tblInspc += `</thead>`;
							tblInspc += `<tbody class="table-border-bottom-0">`;
							for (let i = 0; i < rslt.length; i++) {
								tblInspc += `<tr>`;
								tblInspc += `<td><input type="checkbox" name="checkD"><label for="check"></label></td>`;
								tblInspc += `<td>\${rslt[i].dissCodeNo}</td>`;
								tblInspc += `<td>\${rslt[i].dissKorName}</td>`;
								tblInspc += `<td>\${rslt[i].dissEngName}</td>`;
								tblInspc += `</tr>`;
							}
							tblInspc += `</tbody>`;
							tblInspc += `</table>`;
							tblInspc += `</div>`;
							dissList.innerHTML = tblInspc;
						}
					}
					xhr.send();
				}

				//질병 검색하기
				function searchDiss() {
					console.log("질병버튼눌렸당");
					console.log("질병내용" + dissKorName.value);

					let xhr = new XMLHttpRequest();
					let schURL = `/doctor/clinic/chart/order/diss/\${dissKorName.value}`
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = () => {
						if (xhr.readyState == 4 && xhr.status == 200) {
							console.log("질병내용 도착");

							// JSON 문자열을 JSON 객체로 바꿔야 편하게 쓸 수 있음
							let rslt = JSON.parse(xhr.responseText);
							console.log(rslt);
							let tblInspc = `<div class="card-body">`;
							tblInspc += `<table class="table table-hover">`;
							tblInspc += `<thead>`;
							tblInspc += `<tr id="tr1">`;
							tblInspc += `<th id="th1" style="width: 70px;">선택</th>`;
							tblInspc += `<th id="th2" style="width: 100px;">질병 코드</th>`;
							tblInspc += `<th id="th3">질병 국문명</th>`;
							tblInspc += `<th id="th4">질병 영문명</th>`;
							tblInspc += `</tr>`;
							tblInspc += `</thead>`;
							tblInspc += `<tbody class="table-border-bottom-0">`;
							for (let i = 0; i < rslt.length; i++) {
								tblInspc += `<tr>`;
								tblInspc += `<td><input type="checkbox" name="checkD"><label for="check"></label></td>`;
								tblInspc += `<td>\${rslt[i].dissCodeNo}</td>`;
								tblInspc += `<td>\${rslt[i].dissKorName}</td>`;
								tblInspc += `<td>\${rslt[i].dissEngName}</td>`;
								tblInspc += `</tr>`;
							}
							tblInspc += `</tbody>`;
							tblInspc += `</table>`;
							tblInspc += `</div>`;
							dissList.innerHTML = tblInspc;
						}
					}
					xhr.send();
				}


				//체크한 질병이 찍히기 위한
				var dissCodeNoList = [];
				var dissKorNameList = [];
				var dissEngNameList = [];

				//체크한 질병 찍히게
				function checkDiss() {
					console.log("질병질병 눌렸당!");
					console.log("체크된 체크박스의 갯수: " + $("input[name=checkD]:checked").length);


					// 체크된 체크박스 가져오기
					var checkbox = $("input[name=checkD]:checked");

					// 체크된 체크박스의 값을 반복해 불러오기
					checkbox.each(function (i) {
						var tr = checkbox.parent().parent().eq(i); // checkbox의 부모는 td
						var th = tr.children(); // td의 부모는 tr

						var dissCodeNo = th.eq(1).text(); // th의 1번째는 질병코드
						var dissKorName = th.eq(2).text(); // th의 2번째는 질병국문명
						var dissEngName = th.eq(3).text(); // th의 3번째는 질병영문명

						dissCodeNoList.push(dissCodeNo);
						dissKorNameList.push(dissKorName);
						dissEngNameList.push(dissEngName);
					});

					console.log(dissCodeNoList);
					console.log(dissKorNameList);
					console.log(dissEngNameList);

					dissModal.style.display = "none"; // 질병오더 검색창 닫깅

					let tblInspc2 = `<div class="card-body">`;
					tblInspc2 += `<table class="table table-hover">`;
					tblInspc2 += `<thead>`;
					tblInspc2 += `<tr>`;
					tblInspc2 += `<th style="width: 100px;">질병 코드</th>`;
					tblInspc2 += `<th>질병 국문명</th>`;
					tblInspc2 += `<th>질병 영문명</th>`;
					tblInspc2 += `</tr>`;
					tblInspc2 += `</thead>`;
					tblInspc2 += `<tbody class="table-border-bottom-0">`;
					for (let i = 0; i < dissCodeNoList.length; i++) {
						tblInspc2 += `<tr>`;
						tblInspc2 += `<td>\${dissCodeNoList[i]}</td>`;
						tblInspc2 += `<td>\${dissKorNameList[i]}</td>`;
						tblInspc2 += `<td>\${dissEngNameList[i]}</td>`;
						tblInspc2 += `</tr>`;
					}
					tblInspc2 += `</tbody>`;
					tblInspc2 += `</table>`;
					tblInspc2 += `</div>`;
					for (let i = 0; i < dissCodeNoList.length; i++) {
						console.log("한번바방", dissCodeNoList[i], dissKorNameList[i], dissEngNameList[i]);
						//let hi = dissCodeNoList[i] +" | "+ dissKorNameList[i];
						$("#grpOrd").val(dissCodeNoList[i]);
					}
					dissOrder.innerHTML = tblInspc2;

				}


				//처방약품 조회하기
				function getMedi() {

					let xhr = new XMLHttpRequest();
					let schURL = `/doctor/clinic/chart/order/medi`
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = () => {
						if (xhr.readyState == 4 && xhr.status == 200) {

							// JSON 문자열을 JSON 객체로 바꿔야 편하게 쓸 수 있음
							let rslt = JSON.parse(xhr.responseText);
							console.log(rslt);
							let tblInspc = `<div class="card-body" style="padding: 1.0rem 1.5rem 0rem;">`;
							tblInspc += `<table class="table table-hover">`;
							tblInspc += `<thead>`;
							tblInspc += `<tr id="tr1">`;
							tblInspc += `<th id="th1">선택</th>`;
							tblInspc += `<th id="th2">약품 코드</th>`;
							tblInspc += `<th id="th3">약품명</th>`;
							tblInspc += `<th id="th5">제조사</th>`;
							tblInspc += `<th id="th6">단위</th>`;
							tblInspc += `<th id="th7">용법</th>`;
							tblInspc += `<th id="th8">마약성여부</th>`;
							tblInspc += `<th id="th9">가격</th>`;
							tblInspc += `</tr>`;
							tblInspc += `</thead>`;
							tblInspc += `<tbody class="table-border-bottom-0">`;
							for (let i = 0; i < rslt.length; i++) {
								tblInspc += `<tr>`;
								tblInspc += `<td><input type="checkbox" name="checkM"><label for="check"></label></td>`;
								tblInspc += `<td><small>\${rslt[i].mediItemCode}</small></td>`;
								tblInspc += `<td><small>\${rslt[i].mediItemName}</small></td>`;
								tblInspc += `<td><small>\${rslt[i].mediItemMakr}</small></td>`;
								tblInspc += `<td><small>\${rslt[i].mediItemUnit}</small></td>`;
								tblInspc += `<td><small>\${rslt[i].mediItemUsage}</small></td>`;
								tblInspc += `<td><small>\${rslt[i].narcoticYn}</small></td>`;
								tblInspc += `<td><small>\${rslt[i].mediItemPrice.toLocaleString()}</small> </td>`;
								tblInspc += `</tr>`;
							}
							tblInspc += `</tbody>`;
							tblInspc += `</table>`;
							tblInspc += `</div>`;
							mediList.innerHTML = tblInspc;
						}
					}
					xhr.send();
				}


				//처방약품 검색하기
				function searchMedi() {
					console.log("약품검색버튼눌렸당");
					console.log("약품명" + mediItemName.value);

					let xhr = new XMLHttpRequest();
					let schURL = `/doctor/clinic/chart/order/medi/\${mediItemName.value}`
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = () => {
						if (xhr.readyState == 4 && xhr.status == 200) {
							console.log("처방내용 도착");

							// JSON 문자열을 JSON 객체로 바꿔야 편하게 쓸 수 있음
							let rslt = JSON.parse(xhr.responseText);
							console.log(rslt);
							let tblInspc = `<div class="card-body" style="padding: 1.0rem 1.5rem 0rem;">`;
							tblInspc += `<table class="table table-hover">`;
							tblInspc += `<thead>`;
							tblInspc += `<tr id="tr1">`;
							tblInspc += `<th id="th1">선택</th>`;
							tblInspc += `<th id="th2">약품 코드</th>`;
							tblInspc += `<th id="th3">약품명</th>`;
							tblInspc += `<th id="th5">제조사</th>`;
							tblInspc += `<th id="th6">단위</th>`;
							tblInspc += `<th id="th7">용법</th>`;
							tblInspc += `<th id="th8">마약성여부</th>`;
							tblInspc += `<th id="th9">가격</th>`;
							tblInspc += `</tr>`;
							tblInspc += `</thead>`;
							tblInspc += `<tbody class="table-border-bottom-0">`;
							for (let i = 0; i < rslt.length; i++) {
								tblInspc += `<tr>`;
								tblInspc += `<td><input type="checkbox" name="checkM"><label for="check"></label></td>`;
								tblInspc += `<td>\${rslt[i].mediItemCode}</td>`;
								tblInspc += `<td>\${rslt[i].mediItemName}</td>`;
								tblInspc += `<td>\${rslt[i].mediItemMakr}</td>`;
								tblInspc += `<td>\${rslt[i].mediItemUnit}</td>`;
								tblInspc += `<td>\${rslt[i].mediItemUsage}</td>`;
								tblInspc += `<td>\${rslt[i].narcoticYn}</td>`;
								tblInspc += `<td>\${rslt[i].mediItemPrice.toLocaleString()}</td>`;
								tblInspc += `</tr>`;
							}
							tblInspc += `</tbody>`;
							tblInspc += `</table>`;
							tblInspc += `</div>`;
							mediList.innerHTML = tblInspc;
						}
					}
					xhr.send();
				}


				//체크한 처방이 찍히기 위한
				var mediItemCodeList = [];
				var mediItemNameList = [];
				var mediItemPriceList = [];

				//체크한 처방 찍히게
				function checkMedi() {
					console.log("처방처방 눌렸당!");
					console.log("체크된 체크박스의 갯수: " + $("input[name=checkM]:checked").length);


					// 체크된 체크박스 가져오기
					var checkbox = $("input[name=checkM]:checked");

					// 체크된 체크박스의 값을 반복해 불러오기
					checkbox.each(function (i) {
						var tr = checkbox.parent().parent().eq(i); // checkbox의 부모는 td
						var th = tr.children(); // td의 부모는 tr

						var mediItemCode = th.eq(1).text(); // th의 1번째는 약품코드
						var mediItemName = th.eq(2).text(); // th의 2번째는 약품명
						var mediItemPrice = th.eq(7).text(); // th의 7번째는 약품가격

						mediItemCodeList.push(mediItemCode);
						mediItemNameList.push(mediItemName);
						mediItemPriceList.push(mediItemPrice);
					});

					//     console.log(dissCodeNoList);


					mediModal.style.display = "none"; // 처방오더 검색창 닫깅

					let tblInspc2 = `<div class="card-body">`;
					tblInspc2 += `<table class="table table-hover" id="mediTable">`;
					tblInspc2 += `<thead>`;
					tblInspc2 += `<tr>`;
					tblInspc2 += `<th>약품 코드</th>`;
					tblInspc2 += `<th>약품명</th>`;
					tblInspc2 += `<th>투약량</th>`;
					tblInspc2 += `<th>투약횟수</th>`;
					tblInspc2 += `<th>투약일수</th>`;
					tblInspc2 += `</tr>`;
					tblInspc2 += `</thead>`;
					tblInspc2 += `<tbody class="table-border-bottom-0">`;
					for (let i = 0; i < mediItemCodeList.length; i++) {
						tblInspc2 += `<tr>`;
						tblInspc2 += `<td>\${mediItemCodeList[i]}</td>`;
						tblInspc2 += `<td>\${mediItemNameList[i]}</td>`;
						tblInspc2 += `<td><input type="text" class= "form-control-sm medi" placeholder="투약량"></td>`;
						tblInspc2 += `<td><input type="text" class= "form-control-sm medi" placeholder="투약횟수"></td>`;
						tblInspc2 += `<td><input type="text" class= "form-control-sm medi" placeholder="투약일수"></td>`;
						tblInspc2 += `</tr>`;
					}
					tblInspc2 += `</tbody>`;
					tblInspc2 += `</table>`;
					tblInspc2 += `</div>`;
					//      for (let i = 0; i < dissCodeNoList.length; i++) {
					//      console.log("한번바방",dissCodeNoList[i],dissKorNameList[i],dissEngNameList[i]);
					//      }
					mediOrder.innerHTML = tblInspc2;
				}

				//체크한 처방오더 요청을 위한 
				var prscrptnAmountList = [];
				var prscrptnCountList = [];
				var prscrptnDaysList = [];


				//처방오더요청
				function plzMedi() {
					var meditable = document.getElementById('mediTable'); // 'mediTable' 테이블의 DOM 요소를 가져옵니다.
					var rowCount = meditable.rows.length;

					let ifEmpty = false;
					
					for (let i = 0; i < rowCount - 1; i++) {
						var td = meditable.rows[i + 1].getElementsByTagName('td'); // 특정 행의 <td> 요소를 가져옵니다.

						console.log(td);
						console.log(td[2]);
						var prscrptnAmount = td[2].querySelector('input').value; // 투약량
						console.log('투약량:', prscrptnAmount);
						var prscrptnCount = td[3].querySelector('input').value; // 투약횟수
						console.log('투약횟수:', prscrptnCount);
						var prscrptnDays = td[4].querySelector('input').value; // 투약일수
						console.log('투약일수:', prscrptnDays);

						prscrptnAmountList.push(prscrptnAmount);
						prscrptnCountList.push(prscrptnCount);
						prscrptnDaysList.push(prscrptnDays);

						console.log(prscrptnAmountList);
						console.log(prscrptnCountList);
						console.log(prscrptnDaysList);
					    // 빈 값을 검사
					    if (prscrptnAmount === '' || prscrptnCount === '' || prscrptnDays === '') {
					    	ifEmpty = true; // 빈 값을 포함
					        break; // 반복문 중지
					    }
					}

					if(ifEmpty){
						Swal.fire({
							icon: 'warning',
							title : '오더 요청 불가',
							text: '처방 오더 내용을 확인해주세요.'
						});
						
					    // 리스트 비우기
					    prscrptnAmountList.length = 0;
					    prscrptnCountList.length = 0;
					    prscrptnDaysList.length = 0;
					}
					else{
					let data = [];

					for (let i = 0; i < prscrptnAmountList.length; i++) {

						// 금액 천단위 콤마 제거
						let mediItemPrice = parseInt(mediItemPriceList[i].replace(/,/g, ''));
						console.log("mediItemPrice", mediItemPrice);

						//넘겨야 할 data
						let newData = {
							mediItemCode: mediItemCodeList[i],
							prscrptnAmount: prscrptnAmountList[i],
							prscrptnCount: prscrptnCountList[i],
							prscrptnDays: prscrptnDaysList[i],
							mediItemPrice: mediItemPrice,
							detailNo: $("#detailNo2").val()
						};
						
						data.push(newData);
						console.log("처방이거당!", newData);					
					}
					
					let xhr = new XMLHttpRequest();
					xhr.open("post", "/doctor/clinic/chart/order/medi", true);
					xhr.setRequestHeader("Content-Type", "application/json;charset=utf-8");
					//여기는 json문자열이 들어있어용
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4 && xhr.status == 200) {
							if (xhr.responseText == "success") {
								Swal.fire({
									icon: 'success',
									title: '오더 요청 완료',
									text: '처방 오더 요청이 완료되었습니다.'
								});
							} else if (prscrptnAmountList.length == 0) {
								alert("뭔가 잘못되었어용");
							}
							//console.log("처방오더 insert체킁", xhr.responseText); // 성공시 1이 찍힌당          
						}
					}
					xhr.send(JSON.stringify(data)); //문자열 (json형식의 문자열)
				}
				}
				


				//질병코드로 그룹오더 검색하기
				function showGrpOrd() {
					//console.log("약품검색버튼눌렸당");
					//console.log("약품명" + mediItemName.value);
					grpOrdModal.style.display = "block";

					let xhr = new XMLHttpRequest();
					let schURL = `/doctor/clinic/chart/order/grpord/\${dissCodeNo.value}`
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = () => {
						if (xhr.readyState == 4 && xhr.status == 200) {
							//console.log("그룹오더 조회 도착");

							// JSON 문자열을 JSON 객체로 바꿔야 편하게 쓸 수 있음
							let rslt = JSON.parse(xhr.responseText);
							//console.log(rslt);
							//console.log(rslt.length);

							if (rslt.length == 0) {
								let tblInspc = `<div class="card-body" style="height:600px;">`;
								tblInspc += `<h5 class="pb-2 border-bottom mb-4"  style="font-weight: bold; color : red;">※그룹오더가 존재하지 않는 질병입니다.</h5>`;
								tblInspc += `</div>`;
								grpOrdList.innerHTML = tblInspc;

								$("#grpOrdBtn").hide(); // 등록버튼 숨기기
							} else {
								let tblInspc = `<div class="card-body">`;
								tblInspc += `<h5 class="pb-2 border-bottom mb-4"  style="font-weight: bold;">그룹오더명:\${rslt[0].grpOrdrNm}</h5>`;
								tblInspc += `<table class="table table-hover" id="a">`;
								tblInspc += `<thead>`;
								tblInspc += `<tr id="tr1">`;
								tblInspc += `<th id="th1">선택</th>`;
								tblInspc += `<th id="th2">오더종류</th>`;
								tblInspc += `<th id="th3">오더내용</th>`;
								tblInspc += `<th id="th4">오더코드</th>`;
								tblInspc += `</tr>`;


								tblInspc += `</thead>`;
								tblInspc += `<tbody class="table-border-bottom-0">`;
								for (let i = 0; i < rslt.length; i++) {
									tblInspc += `<tr>`;
									tblInspc += `<td><input type="checkbox" name="checkG"><label for="check"></label></td>`;

									// 조건부 스타일 적용
									if (rslt[i].ordrClass === '처치') {
										tblInspc += `<td><span class="badge bg-success">\${rslt[i].ordrClass}</span></td>`; // 초록 배지
									} else if (rslt[i].ordrClass === '치료') {
										tblInspc += `<td><span class="badge bg-warning">\${rslt[i].ordrClass}</span></td>`;// 주황 배지

									} else {
										tblInspc += `<td><span class="badge bg-info">\${rslt[i].ordrClass}</span></td>`; // 파란 배지

									}

									tblInspc += `<td>\${rslt[i].ordrContent}</td>`;
									tblInspc += `<td>\${rslt[i].ordrCode}</td>`;
									tblInspc += `<td class="hidden-cell">\${rslt[i].ordrCost}</td>`;
									tblInspc += `</tr>`;
								}
								tblInspc += `</tbody>`;
								tblInspc += `</table>`;
								tblInspc += `</div>`;
								grpOrdList.innerHTML = tblInspc;
							}
						}
					}
					xhr.send();
				}


				// 등록버튼 눌러서 그룹오더 찍히게 goGrpOrd()

				var grpOrdrNoList = [];

				var treatClsList = [];
				var treatContentList = [];
				var treCodeList = [];
				var treCostsList = [];

				var physioClsList = [];
				var physioContentList = [];
				var physioCodeList = [];
				var physioCostList = [];

				var mediClsList = [];
				var mediContentList = [];
				var mediItemCodeList = [];
				var mediItemPriceList = [];

				function goGrpOrd() {
					//console.log("등록버튼 눌렸당!");

					// "a" 테이블의 행 수 가져오기
					var rowCount = $("#a tbody tr").length;
					var tr = $("#a tbody tr");
					//console.log("!", rowCount, tr.eq(2).text()); //2번째
					// 체크된 체크박스 가져오기
					var checkbox = $("input[name=checkG]:checked");

					// 체크된 체크박스의 값을 반복해 불러오기
					checkbox.each(function (i) {

						var tr2 = checkbox.parent().parent().eq(i);
						var th = tr2.children(); // td의 부모는 tr

						var cls = th.eq(1).text(); // th의 1번째는 오더종류
						var content = th.eq(2).text(); // th의 2번째는 오더 내용
						var code = th.eq(3).text(); // th의 3번째는 오더 코드
						var cost = th.eq(4).text(); // th의 4번째는 오더 비용

						//console.log('cls', cls);
						//console.log('content', content);
						//console.log('code', code);
						if (cls == '처치') {
							treatClsList.push(cls); // 오더종류
							treatContentList.push(content);  // 내용
							treCodeList.push(code);   // 오더코드
							treCostsList.push(cost);   // 오더비용
						} else if (cls == '치료') {
							physioClsList.push(cls); // 오더종류
							physioContentList.push(content);  // 내용
							physioCodeList.push(code);   // 오더코드
							physioCostList.push(cost);   // 오더비용
						} else {
							mediClsList.push(cls); // 오더종류
							mediContentList.push(content);  // 내용
							mediItemCodeList.push(code);   // 오더코드
							mediItemPriceList.push(cost);   // 오더비용
						}
					});

// 					console.log("처치유형리스트", treatClsList);
// 					console.log("처치내용리스트", treatContentList);
// 					console.log("처치코드리스트", treCodeList);

// 					console.log("physioClsList", physioClsList);
// 					console.log("physioContentList", physioContentList);
// 					console.log("physioCodeList", physioCodeList);

// 					console.log("mediClsList", mediClsList);
// 					console.log("mediContentList", mediContentList);
// 					console.log("mediCodeList", mediItemCodeList);


					grpOrdModal.style.display = "none"; // 그룹오더 조회창 닫깅


					let tblTreat = `<div class="card-body">`;
					tblTreat += `<table class="table table-hover">`;
					tblTreat += `<thead>`;
					tblTreat += `<tr>`;
					tblTreat += `<th>처치 코드</th>`;
					tblTreat += `<th>처치 내용</th>`;
					tblTreat += `<th>처치 비용</th>`;
					tblTreat += `</tr>`;
					tblTreat += `</thead>`;
					tblTreat += `<tbody class="table-border-bottom-0">`;
					for (let i = 0; i < treatClsList.length; i++) {
						tblTreat += `<tr>`;
						tblTreat += `<td>\${treCodeList[i]}</td>`;
						tblTreat += `<td>\${treatContentList[i]}</td>`;
						tblTreat += `<td>\${treCostsList[i]}</td>`;
						tblTreat += `</tr>`;
					}
					tblTreat += `</tbody>`;
					tblTreat += `</table>`;
					tblTreat += `<textarea class="form-control" id="treMemo" name="treMemo" rows="2" style="width:100%;" placeholder="처치메모를 작성해주세요."></textarea>`
					tblTreat += `</div>`;
					treatOrder.innerHTML = tblTreat;


					let tblPhysio = `<div class="card-body">`;
					tblPhysio += `<table class="table table-hover">`;
					tblPhysio += `<thead>`;
					tblPhysio += `<tr>`;
					tblPhysio += `<th>치료 코드</th>`;
					tblPhysio += `<th>치료 내용</th>`;
					tblPhysio += `<th>치료 비용</th>`;
					tblPhysio += `</tr>`;
					tblPhysio += `</thead>`;
					tblPhysio += `<tbody class="table-border-bottom-0">`;
					for (let i = 0; i < physioClsList.length; i++) {
						tblPhysio += `<tr>`;
						tblPhysio += `<td>\${physioCodeList[i]}</td>`;
						tblPhysio += `<td>\${physioContentList[i]}</td>`;
						tblPhysio += `<td>\${physioCostList[i]}</td>`;
						tblPhysio += `</tr>`;
					}
					tblPhysio += `</tbody>`;
					tblPhysio += `</table>`;
					tblPhysio += `</div>`;
					physioOrder.innerHTML = tblPhysio;


					let tblMedi = `<div class="card-body">`;
					tblMedi += `<table class="table table-hover" id="mediTable">`;
					tblMedi += `<thead>`;
					tblMedi += `<tr>`;
					tblMedi += `<th>약품 코드</th>`;
					tblMedi += `<th>약품명</th>`;
					tblMedi += `<th>투약량</th>`;
					tblMedi += `<th>투약횟수</th>`;
					tblMedi += `<th>투약일수</th>`;
					tblMedi += `</tr>`;
					tblMedi += `</thead>`;
					tblMedi += `<tbody class="table-border-bottom-0">`;
					for (let i = 0; i < mediClsList.length; i++) {
						tblMedi += `<tr>`;
						tblMedi += `<td>\${mediItemCodeList[i]}</td>`;
						tblMedi += `<td>\${mediContentList[i]}</td>`;
						tblMedi += `<td><input type="text" class= "form-control-sm medi" placeholder="투약량"></td>`;
						tblMedi += `<td><input type="text" class= "form-control-sm medi" placeholder="투약횟수"></td>`;
						tblMedi += `<td><input type="text" class= "form-control-sm medi" placeholder="투약일수"></td>`;
						tblMedi += `</tr>`;
					}
					tblMedi += `</tbody>`;
					tblMedi += `</table>`;
					tblMedi += `</div>`;

					mediOrder.innerHTML = tblMedi;

				};

				// 진료완료 버튼 클릭 시
				function endClinic() {				
					if($("#grpOrd").val() == ''){
						Swal.fire({
							icon: 'warning',
							title: '진료완료 불가',
							text: '질병란을 확인해 주세요.'
						});												
					}else if($("#detailMemo1").val() == '' ){
						Swal.fire({
							icon: 'warning',
							title: '진료완료 불가',
							text: '증상메모를 입력해 주세요.'
						});						
					}else{
					//var patHsptlzStatus = '1'; // 기본값으로 외래 설정
					var patHsptlzStatus = '';

					if ($("#patHsptlzStatusIn").is(":checked")) {
						patHsptlzStatus = '2'; // 외래 환자 입원 결정시
					} else if ($("#hsptYN strong").text() === "입원중") {
						if ($("#patHsptlzStatusOut").is(":checked")) {
							patHsptlzStatus = '5'; // 입원 환자 퇴원 결정시
						} else {
							patHsptlzStatus = '4'; // 입원 환자 입원 유지시
						}
					}

					//console.log("patHsptlzStatus", patHsptlzStatus);

					// 넘겨야 할 data
					let data = {
						dissCodeNo: $("#grpOrd").val(),
						detailMemo: $("#detailMemo1").val(),
						detailNo: $("#detailNo2").val(),
						treatNo: $("#treatNo").val(),
						patHsptlzStatus: patHsptlzStatus,
						patHsptlzOutPlan: $("#patHsptlzOutPlan").val(),
						patCode: $("#patCode0").val()
					}

					let dissCodeNo = $("#grpOrd").val();
					let detailMemo = $("#detailMemo1").val();
					let detailNo = $("#detailNo2").val();
					let patCode = $("#patCode0").val();
					let patHsptlzOutPlan = $("#patHsptlzOutPlan").val();

// 					console.log("질병코드", dissCodeNo);
// 					console.log("증상메모", detailMemo);
// 					console.log("차트번호", detailNo);
// 					console.log("진료번호", treatNo);
// 					console.log("환자코드", patCode);
// 					console.log("퇴원예정일", patHsptlzOutPlan);
// 					console.log("입원상태", patHsptlzStatus);

					let xhr = new XMLHttpRequest();
					let schURL = `/doctor/clinic/chart/done`;
					xhr.open("put", schURL, true);
					xhr.setRequestHeader("Content-Type", "application/json;charset=utf-8");

					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4 && xhr.status == 200) {
							if (xhr.responseText > 0) {
								//console.log("체크", xhr.responseText); // 성공시 3이 찍힌당
								Swal.fire({
									icon: 'success',
									title: '완료',
									text: '진료가 완료되었습니다.'
								});

								//console.log("소켓에 보낼", patHsptlzStatus);
								if (patHsptlzStatus == '2') {

									// 웹소켓으로  입원 결정 연락!
									let inMsg = {
										to: "원무과",
										from: "의사",
										cmd: "plzHosp"
									}
									webSocket.send(JSON.stringify(inMsg));
									console.log(inMsg, "inMsg보냈는뎅");

								} else if (patHsptlzStatus == '5') {

									// 웹소켓으로  퇴원 결정 연락!
									let outMsg = {
										to: "원무과",
										from: "의사",
										cmd: "endHosp"
									}
									webSocket.send(JSON.stringify(outMsg));
									console.log(outMsg, "outMsg보냈는뎅");
								}
								getWaitPat();
								allClear();
							} else {
								alert("뭔가 잘못되었어용");
							}
							console.log("진료완료체킁", xhr.responseText);
						}
					}
					xhr.send(JSON.stringify(data)); // 문자열 (JSON 형식의 문자열)
				}
				}


				// 입원가능병상 count    
				function cntEmptBed(callback) {
					let xhr = new XMLHttpRequest();
					xhr.open("get", "/doctor/clinic/chart/cntbed", true);
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4 && xhr.status == 200) {
							console.log("입원가능병상 count체킁", xhr.responseText);
							$("#bedCnt").val(xhr.responseText);
							callback();
						}
					}
					xhr.send();
				}

				// 환자 호출 제외 접수번호로 진료번호, 차트번호 출력
				function getChtNoByRceptNo() {
					let rceptNo = $("#rceptNo0").val();
					//console.log("접수번호 찍어보깅", rceptNo);

					let xhr = new XMLHttpRequest();
					let schURL = "/doctor/clinic/pat/" + rceptNo;
					console.log(schURL);
					xhr.open("get", schURL, true);
					xhr.onreadystatechange = function () {
						if (xhr.readyState == 4 && xhr.status == 200) {
							console.log("성공!");
							let clinicChartRecPatVO = xhr.responseText;
							if (clinicChartRecPatVO) {
								clinicChartRecPatVO = JSON.parse(clinicChartRecPatVO); //json문자열을 json객체로
								console.log("진료번호차트번호찍어보기", clinicChartRecPatVO);

								$("#detailNo2").val(clinicChartRecPatVO.detailNo);

								$("#treatNo").val(clinicChartRecPatVO.treatNo);

							} else {
								alert("환자 호출 제외 접수번호로 진료번호, 차트번호 출력 오류.");
							}
						}
					}
					xhr.send();
				}

				var target = $('.target');
				//1
				var zoom = target.data('zoom');

				enlargePhoto();
				// 			    $(".wrap")
				// 			        .on('mousemove', magnify)
				// 			        .prepend("<div class='magnifier'></div>")
				// 			        .children('.magnifier').css({
				// 			            "background": "url('" + target.attr("src") + "') no-repeat",
				// 			            // 2
				// 			            "background-size": target.width() * zoom + "px " + target.height() * zoom+ "px"
				// 			        });

				var magnifier = $('.magnifier');

				function magnify(e) {

					// 1
					var mouseX = e.pageX - $(this).offset().left;
					var mouseY = e.pageY - $(this).offset().top;

					// 2
					if (mouseX < $(this).width() && mouseY < $(this).height() && mouseX > 0 && mouseY > 0) {
						magnifier.fadeIn(100);
					} else {
						magnifier.fadeOut(100);
					}

					//돋보기가 존재할 때
					if (magnifier.is(":visible")) {

						// 3
						var rx = -(mouseX * zoom - magnifier.width() / 2);
						var ry = -(mouseY * zoom - magnifier.height() / 2);

						//돋보기를 마우스 위치에 따라 움직인다.
						//돋보기의 width, height 절반을 마우스 좌표에서 차감해 마우스와 돋보기 위치를 일치시킨다.
						var px = mouseX - magnifier.width() / 2;
						var py = mouseY - magnifier.height() / 2;

						//적용
						magnifier.css({
							left: px,
							top: py,
							backgroundPosition: rx + "px " + ry + "px"
						});
					}
				}


				//비우기함수
				function allClear() {
					// 모든 input, textarea, date input, checkbox, table 요소를 찾습니다.
					$('.card-body').find('input[type=text], textarea, input[type=date], input[type=checkbox], table').each(function () {
						if ($(this).is('input[type=text], textarea, input[type=date]')) {
							$(this).val('');
						} else if ($(this).is('input[type=checkbox]')) {
							$(this).prop('checked', false); // 체크박스 체크 해제
						} else if ($(this).is('table')) {
							// 테이블 셀 안에 있는 내용만 삭제합니다.
							$(this).find('td').text('');
						}
					});

					$('.modal-content').find('input[type=text], textarea, input[type=date], input[type=checkbox], table').each(function () {
						if ($(this).is('input[type=text], textarea, input[type=date], input[type=checkbox]')) {
							$(this).val('');
						} else if ($(this).is('table')) {
							// 테이블 셀 안에 있는 내용만 삭제합니다.
							$(this).find('td').text('');
						}
					});
					inspcCostList.length = 0;
					inspcCodeList.length = 0;
					inspcTypeList.length = 0;
					treContentList.length = 0;
					treCodeList.length = 0;
					treCodeList.length = 0;
					physioCodeList.length = 0;
					physioCostList.length = 0;
					physioContentList.length = 0;
					mediItemCodeList.length = 0;
					mediItemNameList.length = 0;
					mediItemPriceList.length = 0;
					dissCodeNoList.length = 0;
					dissKorNameList.length = 0;
					dissEngNameList.length = 0;
					grpOrdrNoList.length = 0;
					treatClsList.length = 0;
					treatContentList.length = 0;
					treCodeList.length = 0;
					treCostsList.length = 0;
					physioClsList.length = 0;
					physioContentList.length = 0;
					physioCodeList.length = 0;
					physioCostList.length = 0;
					mediClsList.length = 0;
					mediContentList.length = 0;
					mediItemCodeList.length = 0;
					mediItemPriceList.length = 0;
				}


				//창닫기버튼
				function closeDetailModal() {
					var detailModal = document.getElementById("detailModal");
					detailModal.style.display = "none";
					inspcModal.style.display = "none";
					treatModal.style.display = "none";
					physioModal.style.display = "none";
					mediModal.style.display = "none";
					dissModal.style.display = "none";
					grpOrdModal.style.display = "none";
					inspcPhotoModal.style.display = "none";
				}

				// 날짜 변환 함수
				function formatDate(inputDate) {
					let options = { year: 'numeric', month: '2-digit', day: '2-digit' };
					let date = new Date(inputDate);
					return date.toLocaleString(undefined, options);
				}

				// 				function fZoom(){
				// 					$('#ex4').zoom({ on:'toggle' });
				// 				}
			</script>
		</body>

		</html>