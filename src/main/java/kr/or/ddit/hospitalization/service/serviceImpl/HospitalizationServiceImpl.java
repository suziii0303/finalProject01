package kr.or.ddit.hospitalization.service.serviceImpl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.hospitalization.mapper.HospitalizationChartDetailMapper;
import kr.or.ddit.hospitalization.mapper.HospitalizationMapper;
import kr.or.ddit.hospitalization.service.HospitalizationService;
import kr.or.ddit.hospitalization.vo.SickRoomTypeVO;
import kr.or.ddit.hospitalization.vo.SickbedVO;
import kr.or.ddit.order.vo.HospitalizationVO;
import kr.or.ddit.patient.vo.PatientVO;
import kr.or.ddit.receipt.vo.HosRRoomVO;
import kr.or.ddit.receipt.vo.HosReceiptionVO;
import kr.or.ddit.receipt.vo.WaitPatVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class HospitalizationServiceImpl implements HospitalizationService{
	@Autowired
	private HospitalizationMapper hospMapper;
	@Autowired
	private HospitalizationChartDetailMapper hospitalizationChartDetailMapper;
	
	@Override
	public List<WaitPatVO> hosptPatWaitList() {
		return hospMapper.hosptPatWaitList();
	}


	@Override
	public List<SickRoomTypeVO> selectRoomData() {
		return hospMapper.selectRoomData();
	}
	@Override
	public int updateBdCondition(String sckrmNo, String sckBdNo) {
		log.info("sckrmNo:-->"+sckrmNo);
		log.info("sckBdNo:"+sckBdNo);
		SickbedVO sickbedVO = new SickbedVO();
		int sckrmNo1 = Integer.parseInt(sckrmNo);
		int sckBdNo1 = Integer.parseInt(sckBdNo);
		sickbedVO.setSckrmNo(sckrmNo1);
		sickbedVO.setSckBdNo(sckBdNo1);
		log.info("FULL 확인:"+sickbedVO);
		return hospMapper.updateBdCondition(sickbedVO);
	}
	@Override
	public int updateBdConditionEmpt(String sckrmNo, String sckBdNo) {
		log.info("sckrmNo:-->"+sckrmNo);
		log.info("sckBdNo:"+sckBdNo);
		SickbedVO sickbedVO = new SickbedVO();
		int sckrmNo1 = Integer.parseInt(sckrmNo);
		int sckBdNo1 = Integer.parseInt(sckBdNo);
		sickbedVO.setSckrmNo(sckrmNo1);
		sickbedVO.setSckBdNo(sckBdNo1);
		log.info("EMPT확인:"+sickbedVO);
		return hospMapper.updateBdConditionEmpt(sickbedVO);
	}
//-------------------------------------------------
	@Override
	@Transactional
	public int updateHsptlzStatus(PatientVO patientVO,HospitalizationVO hospitalizationVO) {
		int cnt = hospMapper.updateHsptlzStatus(patientVO);
		cnt += hospMapper.updateHsptlzRoom(hospitalizationVO);
		return cnt;
	}


	@Override
	public List<HospitalizationVO> selectHsptlzstatus() {
	
		return hospMapper.selectHsptlzstatus();
	}

	@Override
	public List<HospitalizationVO> getReqHospitalizationList() {
		return hospMapper.getReqHospitalizationList();
	}
	
	@Override
	public HospitalizationVO getReqHospitalization(String hsptlzNo) {
		HospitalizationVO hospitalizationVO = new HospitalizationVO();
		hospitalizationVO.setHsptlzNo(hsptlzNo);
		return hospMapper.getReqHospitalization(hospitalizationVO);
	}
	
	@Override
	@Transactional
	public int updateWhenInHospitalization(HospitalizationVO hospitalizationVO) {
		String patCode = hospitalizationVO.getPatCode();
		String hsptlzNo = hospitalizationVO.getHsptlzNo();
		int cnt = hospMapper.updatePatInHos(patCode);
		cnt += hospMapper.updateInHosVO(hsptlzNo);
		return cnt;
	}
	
	@Override
	public int updateOutHosVO(String hsptlzNo) {
		return hospMapper.updateOutHosVO(hsptlzNo);

	}
	
	@Override
	public int updatePatOutHos(String patCode) {
		return hospMapper.updatePatOutHos(patCode);
	}
	
	@Transactional
	@Override
	public List<HosReceiptionVO> getHosReceiptionContent(String hsptlzNo) {
		List<HosReceiptionVO> list = new ArrayList<HosReceiptionVO>();
		hospMapper.updateOutHosVO(hsptlzNo);
		list = hospMapper.getDetailNoDuringInHos(hsptlzNo);
		for(int i=0; i<list.size(); i++) {
			String detailNo = list.get(i).getDetailNo();
			list.get(i).setHosRInspcVOList(hospitalizationChartDetailMapper.getHosRInspcList(detailNo));
			list.get(i).setHosRPhysioVOList(hospitalizationChartDetailMapper.getHosRPhysioList(detailNo));
			list.get(i).setHosRPrescriptionVOList(hospitalizationChartDetailMapper.getHosRPrescriptionList(detailNo));
			list.get(i).setHosRTreatVOList(hospitalizationChartDetailMapper.getHosRTreatList(detailNo));
		}
		log.info("hosReceiptionVOList : " + list.toString());
		return list;
	}
	
	@Override
	@Transactional
	public int updateHosRoomPrice(String hsptlzNo) {
		HosRRoomVO hVO = new HosRRoomVO();
		int roomPrice = hospMapper.getRoomPrice(hsptlzNo);
		hVO.setHsptlzNo(hsptlzNo);
		hVO.setSckrmTypePrice(roomPrice);
		int cnt = hospMapper.updateHosRoomPrice(hVO);
		return cnt;
	}

}
