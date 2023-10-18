package kr.or.ddit.employee.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.ddit.employee.vo.EmployeeVO;
import kr.or.ddit.employee.vo.UserAuthoritiesVO;

@Mapper
public interface EmployeeMapper {
	public List<EmployeeVO> listEmployee();
	public EmployeeVO selectEmployeeByNo(String empNo);
	public int delete(String empNo);
	
	/*
	// 회원가입 (경민)
	public int insert(EmployeeVO employeeVO);
	*/
	
	// 권한 INSERT
	public int insertAuth(UserAuthoritiesVO userAuthoritiesVO);
	
	// 이메일 체크
	public int check(String empEmail);
	
	// 비밀번호변경 : 비번up + 상태up
	public int updatePwFrst(EmployeeVO employeeVO);
	
	// 비밀번호찾기  (입력한 회원이 있는지 확인)
	public int checkEmp(EmployeeVO employeeVO);
	
	// 임시 비밀번호 업데이트
	public int updateimsiPw(EmployeeVO employeeVO);
	
	// 정보수정
	public int updatemyInfo(EmployeeVO employeeVO);
	
	//--------------------------------------------------------

	// 다음에 insert 될 사번 가져오기 (예린)
	public String getEmpNo();
	
	// 직원 등록 (예린)
	public int insertEmp(EmployeeVO employeeVO);
	
	// 직원 수정 (예린)
	public int updateEmp(EmployeeVO employeeVO);
}
