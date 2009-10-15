package com.orangeandbronze.batchmon

import grails.test.*

import grails.test.GrailsUnitTestCase
import org.springframework.batch.core.JobParameters
import org.springframework.batch.core.JobInstance
import org.springframework.batch.core.repository.dao.JdbcJobInstanceDao
import org.springframework.batch.core.repository.dao.JdbcJobExecutionDao
import org.springframework.batch.core.repository.dao.JdbcStepExecutionDao
import org.springframework.batch.core.JobExecution

class JobInstanceServiceUnitTests extends GrailsUnitTestCase {
	
	def jobInstanceService
	static final TEST_START_VALUE = 0
	static final TEST_COUNT_VALUE = 20
	static final TEST_JOBNAME_VALUE1 = 'spam'
	static final TEST_JOBNAME_VALUE2 = 'ham'
	static final TEST_JOBID_VALUE = 1L
	static final TEST_JOBNAME_LIST = [TEST_JOBNAME_VALUE1,TEST_JOBNAME_VALUE2]
    static final TEST_JOB_PARAMETERS = new JobParameters()
    static final TEST_JOB_INSTANCE = new JobInstance(TEST_JOBID_VALUE, TEST_JOB_PARAMETERS, TEST_JOBNAME_VALUE1)
	static final TEST_JOB_INSTANCE_LIST = [TEST_JOB_INSTANCE]
    static final TEST_JOB_EXECUTION =new JobExecution(200L)
    static final TEST_JOB_EXECUTION_LIST = [TEST_JOB_EXECUTION]
    protected void setUp() {
        super.setUp()
        jobInstanceService = new JobInstanceService()
    }

    protected void tearDown() {
        super.tearDown()
    }
    
    private GrailsMock makeJobInstanceMockDaoAndDemandGetJobNames() {
    	def mockDao = mockFor(JdbcJobInstanceDao)
    	mockDao.demand.getJobNames(1..1) {->
    		return TEST_JOBNAME_LIST
    	}    	
    	jobInstanceService.jobInstanceDao = mockDao.createMock()
    	return mockDao
    }
    
    private GrailsMock makeJobInstanceMockDaoAndDemandGetJobInstances() {
      	def mockDao = mockFor(JdbcJobInstanceDao)
      	mockDao.demand.getJobInstances(1..1) {jobName, start, count ->
      		assertEquals TEST_JOBNAME_VALUE1, jobName
      		assertEquals TEST_START_VALUE, start
      		assertEquals TEST_COUNT_VALUE, count
      		return TEST_JOB_INSTANCE_LIST
      	}
      	
      	jobInstanceService.jobInstanceDao = mockDao.createMock()
      	return mockDao
    }
    
    private GrailsMock makeJobInstanceMockDaoAndDemandGetJobInstance() {
      	def mockDao = mockFor(JdbcJobInstanceDao)
      	mockDao.demand.getJobInstance(1..1) {id ->
      		assertEquals TEST_JOBID_VALUE, id
      		return TEST_JOB_INSTANCE
      	}
      	
      	jobInstanceService.jobInstanceDao = mockDao.createMock()
      	return mockDao
    }
    private GrailsMock makeJobInstanceMockDaoAndDemandGetJobInstanceWithExecution(){
    	def mockDao = mockFor(JdbcJobInstanceDao)
    	mockDao.demand.getJobInstance(1..1) { jobExecution ->
	  		assertEquals TEST_JOB_EXECUTION, jobExecution
	  		return TEST_JOB_INSTANCE   		
    	}
      	jobInstanceService.jobInstanceDao = mockDao.createMock()
      	return mockDao
    }
    
    private GrailsMock makeStepExecutionMockDaoAndDemandAddStepExecutions() {
      	def mockDao = mockFor(JdbcStepExecutionDao)
      	mockDao.demand.addStepExecutions(1..1) {
      		assertEquals TEST_JOB_EXECUTION, it
      	}
      	jobInstanceService.stepExecutionDao = mockDao.createMock()
      	return mockDao
    }
    private GrailsMock makeJobExecutionMockDaoAndeDemandFindRunningJobExecutions() {
      	def mockDao = mockFor(JdbcJobExecutionDao)
      	mockDao.demand.findRunningJobExecutions(1..1) {jobName ->
      		assertEquals TEST_JOBNAME_VALUE1, jobName
      		return TEST_JOB_EXECUTION_LIST
      	}
      	jobInstanceService.jobExecutionDao = mockDao.createMock()
      	return mockDao
    }
    private GrailsMock makeJobExecutionMockDaoAndDemandGetJobExecution() {
      	def mockDao = mockFor(JdbcJobExecutionDao)
      	mockDao.demand.getJobExecution(1..1) {id ->
      		assertEquals TEST_JOB_EXECUTION.id, id
      		return TEST_JOB_EXECUTION
      	}
      	jobInstanceService.jobExecutionDao = mockDao.createMock()
      	return mockDao
    }
    private GrailsMock makeJobExecutionMockDaoAndDemandFindJobExecutions() {
      	def mockDao = mockFor(JdbcJobExecutionDao)
      	mockDao.demand.findJobExecutions(1..1) { jobInstance ->
      		assertEquals TEST_JOB_INSTANCE, jobInstance
      		return TEST_JOB_EXECUTION_LIST
      	}
      	jobInstanceService.jobExecutionDao = mockDao.createMock()
      	return mockDao
    }
    
    
    void testGetJobNames() {
    	def mockJobInstanceDao = makeJobInstanceMockDaoAndDemandGetJobNames()
        	
    	def jobNames = jobInstanceService.getJobNames()
    	
    	assertNotNull jobNames
    	JobNameControllerTestUtils.checkExpectedList(TEST_JOBNAME_LIST, jobNames)
    	mockJobInstanceDao.verify()
    }
    void testGetJobInstances() {
    
      	def mockJobInstanceDao = makeJobInstanceMockDaoAndDemandGetJobInstances()
      	
      	def jobInstances = jobInstanceService.getJobInstances(TEST_JOBNAME_VALUE1, TEST_START_VALUE, TEST_COUNT_VALUE)
      	
    	JobNameControllerTestUtils.checkExpectedList(TEST_JOB_INSTANCE_LIST, jobInstances)      	
      	mockJobInstanceDao.verify()
    }
    void testGetJobInstance() {
    	
      	def mockJobInstanceDao = makeJobInstanceMockDaoAndDemandGetJobInstance()
      	
      	def jobInstance = jobInstanceService.getJobInstance(TEST_JOBID_VALUE)
      	
    	assertEquals TEST_JOB_INSTANCE, jobInstance  	
    	mockJobInstanceDao.verify()
    }
    void testFindRunningJobExecutions() {
    	
      	def mockJobExecutionDao = makeJobExecutionMockDaoAndeDemandFindRunningJobExecutions()
      	
    	def mockJobInstanceDao = makeJobInstanceMockDaoAndDemandGetJobInstanceWithExecution()
      	         
      	def mockStepExecutionDao = makeStepExecutionMockDaoAndDemandAddStepExecutions()
      	
      	def jobExecutions = jobInstanceService.findRunningJobExecutions(TEST_JOBNAME_VALUE1)
      	
    	JobNameControllerTestUtils.checkExpectedList(TEST_JOB_EXECUTION_LIST, jobExecutions)
    	
    	assertNotNull jobExecutions[0].jobInstance
    	assertEquals TEST_JOB_INSTANCE, jobExecutions[0].jobInstance
    	mockJobExecutionDao.verify()
      	mockJobInstanceDao.verify()
      	mockStepExecutionDao.verify()
    }
    
    void testGetJobExecution() {

    	def mockJobExecutionDao = makeJobExecutionMockDaoAndDemandGetJobExecution()
    
    	def mockJobInstanceDao = makeJobInstanceMockDaoAndDemandGetJobInstanceWithExecution()

      	def mockStepExecutionDao = makeStepExecutionMockDaoAndDemandAddStepExecutions()
      	
      	def jobExecution = jobInstanceService.getJobExecution(TEST_JOB_EXECUTION.id)
      	
      	assertNotNull jobExecution
      	assertEquals TEST_JOB_EXECUTION, jobExecution
    	assertNotNull jobExecution.jobInstance
    	assertEquals TEST_JOB_INSTANCE, jobExecution.jobInstance
      	mockJobExecutionDao.verify()
      	mockJobInstanceDao.verify()
      	mockStepExecutionDao.verify()
      	
    }
    void testFindJobExecutionsWithJobInstance() {
    	
    	def mockJobExecutionDao = makeJobExecutionMockDaoAndDemandFindJobExecutions()
        
      	def mockStepExecutionDao = makeStepExecutionMockDaoAndDemandAddStepExecutions()
    	
    	def jobExecutions = jobInstanceService.findJobExecutions(TEST_JOB_INSTANCE)

    	assertEquals TEST_JOB_EXECUTION_LIST, jobExecutions
    	mockJobExecutionDao.verify()
    	mockStepExecutionDao.verify()
    	
    }
    void testFindJobExecutionsWithJobInstanceId() {
    	
    	def mockJobExecutionDao = makeJobExecutionMockDaoAndDemandFindJobExecutions()
        def mockJobInstanceDao = makeJobInstanceMockDaoAndDemandGetJobInstance()
      	def mockStepExecutionDao = makeStepExecutionMockDaoAndDemandAddStepExecutions()
    	
    	def jobExecutions = jobInstanceService.findJobExecutions(TEST_JOBID_VALUE)

    	assertEquals TEST_JOB_EXECUTION_LIST, jobExecutions
    	mockJobExecutionDao.verify()
    	mockJobInstanceDao.verify()
    	mockStepExecutionDao.verify()
    	
    }
}
