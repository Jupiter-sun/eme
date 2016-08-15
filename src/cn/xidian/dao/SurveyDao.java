package cn.xidian.dao;

import java.util.List;

import cn.xidian.entity.PageBean;
import cn.xidian.entity.Survey;
import cn.xidian.entity.SurveyQuestion;
import cn.xidian.entity.SurveyReplyer;
import cn.xidian.entity.SurveySelector;
import cn.xidian.entity.Teacher;
import cn.xidian.entity.TextAnswer;

public interface SurveyDao {

	boolean createSurvey(Survey survey);

	boolean addQuestion(SurveyQuestion sq);

	boolean updateSurvey(Survey survey);

	boolean addSelector(SurveySelector surveySelector);

	List<Survey> selectAllSurveys(Teacher teacher);

	List<Survey> findSurveys(Teacher teacher, Integer begin, Integer limit);

	Survey selectSurveyById(Integer surveyId);

	List<SurveyQuestion> selectQuestionBysurveyId(Integer surveyId);

	boolean updateSelectorNum(Integer surveyId, Integer questionId, Integer selectorNum);

	SurveyQuestion selectQuestionById(Integer questionId);

	boolean addTextAnswer(TextAnswer textAnswer);

	boolean updateSurveySumById(Integer surveyId);

	boolean addSurveyReplyer(SurveyReplyer surveyReplyer);

	List<SurveySelector> selectSurveySelectors(Integer surveyId, Integer questionId);

	boolean publishSurvey(Integer surveyId);

	boolean deleteSurvey(Integer surveyId);
	
	List<Survey> selectStuSurveys(String role);
	
	List<Survey> findStuSurveys(String role,Integer begin,Integer limit);
}
