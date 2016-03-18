package edu.nju.desserthouse.dao.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.nju.desserthouse.dao.BaseDao;
import edu.nju.desserthouse.dao.MemberDao;
import edu.nju.desserthouse.model.Member;

@Repository
public class MemberDaoImpl implements MemberDao{

	@Autowired
	private BaseDao baseDao;
	
	public BaseDao getBaseDao() {
		return baseDao;
	}

	public void setBaseDao(BaseDao baseDao) {
		this.baseDao = baseDao;
	}
	
	@Override
	public void save(Member member) {
		try {
			baseDao.save(member);

		}catch (Exception e) {			
			e.printStackTrace();
		}
	}

	@Override
	public Member find(int id) {
		Member member = (Member)baseDao.load(Member.class, id);
		return member;
	}

	@Override
	public void updateByUserid(Member member) {
		baseDao.update(member);
	}

	@Override
	public List<Member> getAllMemberList() {
		@SuppressWarnings("unchecked")
		List<Member> list = baseDao.getAllList(Member.class);
		return list;
	}

}
