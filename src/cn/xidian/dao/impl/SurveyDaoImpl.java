package cn.xidian.dao.impl;

import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Component;

import cn.xidian.dao.SurveyDao;
import cn.xidian.entity.Survey;
import cn.xidian.entity.SurveyQuestion;
import cn.xidian.entity.SurveySelector;
import cn.xidian.entity.Teacher;

@Component("surveyDaoImpl")
public class SurveyDaoImpl implements SurveyDao{
	private SessionFactory sessionFactory;

	@Resource(name = "sessionFactory")
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	private Session currentSession() {
		return sessionFactory.getCurrentSession();
	}

	@Override
	public boolean createSurvey(Survey survey) {
		// TODO Auto-generated method stub
		currentSession().save(survey);
		
		return true;
	}

	@Override
	public boolean addQuestion(SurveyQuestion sq) {
		// TODO Auto-generated method stub
		currentSession().save(sq);
		return true;
	}

	@Override
	public boolean updateSurvey(Survey survey) {
		// TODO Auto-generated method stub
		String sql="update Survey s set s.startTime=?,s.endTime=? where s.surveyId=? ";
		Query query=currentSession().createQuery(sql);
		query.setDate(0, survey.getStartTime());
		query.setDate(1, survey.getEndTime());
		query.setInteger(2, survey.getSurveyId());
		query.executeUpdate();
		return true;
	}

	@Override
	public boolean addSelector(SurveySelector surveySelector) {
		// TODO Auto-generated method stub
		currentSession().save(surveySelector);
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Survey> selectAllSurveys(Teacher teacher) {
		// TODO Auto-generated method stub
		String sql="from Survey where tchrId=?";
		Query query=currentSession().createQuery(sql);
		query.setInteger(0, teacher.getTchrId());
		List<Survey> surveys=query.list();
		return surveys;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Survey> findSurveys(Teacher teacher, Integer begin, Integer limit) {
		// TODO Auto-generated method stub
		String sql="from Survey where tchrId=? order by surveyId desc";
		Query query=currentSession().createQuery(sql).setFirstResult(begin).setMaxResults(limit);
		query.setInteger(0, teacher.getTchrId());
		List<Survey> surveys=query.list();
		return surveys;
	}

}
