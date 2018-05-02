package kr.co.vwa.services;

import kr.co.vwa.common.util.SessionUtils;
import kr.co.vwa.domain.BranchVo;
import kr.co.vwa.domain.EmailVo;
import kr.co.vwa.repository.BranchRepository;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 전시장관리 서비스
 */
@Service("branchService")
public class BranchService implements IBranchService{

    @Autowired
    private BranchRepository branchRepository;

    @Value("${mapInfo.clientId}")
    private String clientId;



    /**
     * 전시장관리/목록 전시장 리스트 조회
     * @param searchParam
     * @return
     */
    @Override
    public List<BranchVo> selectBranchList(Map<Object, Object> searchParam) {
        searchParam.put("clientId", clientId);
        return branchRepository.selectBranchList(searchParam);
    }

    /**
     * 전시장관리/목록 노출여부 수정
     * @param branch
     * @return
     */
    @Override
    public int updateExpsYn(BranchVo branch) {
        branch.setUpdUser(SessionUtils.getUser().getUsername());
        return branchRepository.updateExpsYn(branch);
    }

    /**
     * 전시장관리/목록 정렬저장
     * @param index
     * @param exhHallSeq
     * @return
     */
    @Override
    public int updateExpsdNo(Integer[] index, Integer[] exhHallSeq) {

        for (int i = 0; i < index.length; i++){
            BranchVo branch = new BranchVo();
            branch.setExhHallSeq(exhHallSeq[i]);
            branch.setExpsNo(index[i]);
            branch.setUpdUser(SessionUtils.getUser().getUsername());
            branchRepository.updateExpsdNo(branch);
        }
        return index.length;
    }

    /**
     * 전시장관리/등록 전시장정보 등록
     * @param branch
     * @param email
     * @return
     */
    @Override
    public BranchVo registeBranch(BranchVo branch, EmailVo email) {

        //전시장 정보 등록
        //작성자 set
        branch.setCreUser(SessionUtils.getUser().getUsername());
        //전화번호 set
        branch.setTel(branch.getTel1() + "-" + branch.getTel2() + "-" + branch.getTel3());
        //노출여부 set
        branch.setExpsYn("Y".equals(branch.getExpsYn()) ? "Y" : "N");
        //주소검색팝업에서 주소를 선택하지 않고 직접 입력만했을 경우 시군, 기본주소에 값이 없으므로 상세주소에서 값을 가져온다.
        if(branch.getSigun() == null || "".equals(branch.getSigun())){
            String sigun[] = branch.getDetailAddr().split(" ");
            branch.setSigun(sigun[0]);
            branch.setAddr(branch.getDetailAddr());
        }

        branchRepository.registeBranch(branch);

        //대표이메일 정보 등록
        List<EmailVo> emailList = new ArrayList<>();
        //전시장 시퀀스 set
        email.setExhHallSeq(branch.getExhHallSeq());
        //대표이메일 여부 set
        email.setReprEmailYn("Y");
        email.setCreUser(SessionUtils.getUser().getUsername());
        emailList.add(email);
        //기타이메일
        if(email.getEtcEmail() != null){
            for (int i = 0; i < email.getEtcEmail().length; i++){
                EmailVo etcEmail = new EmailVo();
                etcEmail.setExhHallSeq(branch.getExhHallSeq());
                etcEmail.setCreUser(SessionUtils.getUser().getUsername());
                etcEmail.setReprEmailYn("N");
                etcEmail.setEmail(email.getEtcEmail()[i]);
                emailList.add(etcEmail);
            }
        }

        branchRepository.registeEmailList(emailList);

        // IP 등록
        if(!CollectionUtils.isEmpty(branch.getIpAddresses())) {

            for(int i = branch.getIpAddresses().size() ; i > 0 ; i--) {
                if(StringUtils.isBlank(branch.getIpAddresses().get(i-1))) {
                    branch.getIpAddresses().remove(i-1);
                }
            }
            branchRepository.registeIpList(branch);
        }

        return branch;
    }

    /**
     * 전시장관리/상세 전시장정보조회
     * @param seq
     * @return
     */
    @Override
    public Map<String, Object> selectOneBranch(Integer seq) {
        Map<String, Object> resultMap = new HashMap<>();
        BranchVo branch = new BranchVo();
        if(seq != null && seq != 0){
            branch = branchRepository.selectOneBranch(seq);
            if(branch == null) {
                throw new RuntimeException(String.format("조회된 전시장 정보가 존재하지 않습니다. [exhHallSeq : \"%d\"]", seq));
            }
            //번호1, 번호2, 번호3 set
            String tel[] = branch.getTel().split("-");
            branch.setTel1(tel[0]);
            branch.setTel2(tel[1]);
            branch.setTel3(tel[2]);
        }
        resultMap.put("branch", branch);
        resultMap.put("clientId", clientId);

        return resultMap;
    }

    /**
     * 전시장관리/상세 전시장정보수정
     * @param branch
     * @param email
     * @return
     */
    @Override
    public BranchVo updateBranch(BranchVo branch, EmailVo email) {

        //전시장 정보 등록
        //작성자 set
        branch.setUpdUser(SessionUtils.getUser().getUsername());
        //전화번호 set
        branch.setTel(branch.getTel1() + "-" + branch.getTel2() + "-" + branch.getTel3());
        //노출여부 set
        branch.setExpsYn("Y".equals(branch.getExpsYn()) ? "Y" : "N");
        branchRepository.updateBranch(branch);

        //이메일 경우 전부 DB상태값을 'D'로 변경 후 upsert문으로 등록할 이메일이 있으면 DB상태를 'A'로 UPDATE, 없으면 새로 INSERT하도록 한다.
        branchRepository.deleteEmail(branch);
        //대표이메일 정보 등록
        //전시장 시퀀스 set
        email.setExhHallSeq(branch.getExhHallSeq());
        //대표이메일 여부 set
        email.setReprEmailYn("Y");
        email.setCreUser(SessionUtils.getUser().getUsername());
        branchRepository.upsertEmail(email);

        //기타이메일
        if(email.getEtcEmail() != null){
            for (int i = 0; i < email.getEtcEmail().length; i++){
                EmailVo etcEmail = new EmailVo();
                etcEmail.setExhHallSeq(branch.getExhHallSeq());
                etcEmail.setCreUser(SessionUtils.getUser().getUsername());
                etcEmail.setReprEmailYn("N");
                etcEmail.setEmail(email.getEtcEmail()[i]);
                branchRepository.upsertEmail(etcEmail);
            }
        }

        // IP 전체 삭제 후 등록
        branchRepository.deleteIpList(branch);
        if(!CollectionUtils.isEmpty(branch.getIpAddresses())) {

            for(int i = branch.getIpAddresses().size() ; i > 0 ; i--) {
                if(StringUtils.isBlank(branch.getIpAddresses().get(i-1))) {
                    branch.getIpAddresses().remove(i-1);
                }
            }
            branchRepository.registeIpList(branch);
        }

        return branch;
    }

    /**
     * 전시장관리/상세 전시장정보삭제
     * @param branch
     * @param email
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteBranch(BranchVo branch, EmailVo email){
        branch.setUpdUser(SessionUtils.getUser().getUsername());

        //전시장정보삭제(DB상태 'D'로 UPDATE)

        int result = branchRepository.deleteBranch(branch);

        //해당 전시장 이메일정보 삭제(DB상태 'D'로 UPDATE)
        result *= branchRepository.deleteEmail(branch);

        //해당 전시장 이메일정보 삭제(DB상태 'D'로 UPDATE)
        result *= branchRepository.deleteIpAddress(branch);

        return result;
    }

    /**
     * 전시장관리/프론트 그룹정보
     * @param searchParam
     * @return
     */
    @Override
    public List<BranchVo> groupBranchList(Map<Object, Object> searchParam){
        return branchRepository.groupBranchList(searchParam);
    }
}
