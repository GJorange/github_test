package org.zerock.goodsreview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.goodsreview.mapper.GoodsReviewMapper;
import org.zerock.goodsreview.vo.GoodsReviewVO;
import org.zerock.util.page.PageObject;

import lombok.Setter;

@Service
@Qualifier("goodsReviewServiceImpl")
public class GoodsReviewServiceImpl implements GoodsReviewService {

//	// 자동 DI
//	@Setter(onMethod_ = @Autowired)
//	private GoodsReviewMapper mapper;
	
	// 필드에 final 추가하여 생성자 주입 사용
    private final GoodsReviewMapper mapper;

    // 생성자 주입 방식으로 GoodsReviewMapper를 주입
    @Autowired
    public GoodsReviewServiceImpl(GoodsReviewMapper mapper) {
        this.mapper = mapper;
    }
	
	@Override
	public List<GoodsReviewVO> list(PageObject pageObject, Long no) {
		// TODO Auto-generated method stub
		// 전체 데이터 세팅 - 페이지 처리를 위해서
		pageObject.setTotalRow(mapper.getTotalRow(pageObject, no));
		return mapper.list(pageObject, no);
	}

	@Override
	public Integer write(GoodsReviewVO vo) {
		// TODO Auto-generated method stub
		return mapper.write(vo);
	}

	@Override
	public Integer update(GoodsReviewVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public Integer delete(GoodsReviewVO vo) {
		// TODO Auto-generated method stub
		return mapper.delete(vo);
	}

}
