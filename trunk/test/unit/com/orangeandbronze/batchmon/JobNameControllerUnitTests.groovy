package com.orangeandbronze.batchmon

import grails.test.ControllerUnitTestCase
import org.springframework.batch.core.JobParameters
import org.springframework.batch.core.JobInstance
import org.springframework.batch.core.JobExecution

import grails.test.*

class JobNameControllerUnitTests extends ControllerUnitTestCase {
	static final TEST_JOBNAME_VALUE1 = 'spam'
	static final TEST_JOBNAME_VALUE2 = 'ham'
	static final TEST_JOBID_VALUE = 1L
	static final TEST_JOBEXECUTIONID_VALUE = 100L
	static final TEST_JOB_PARAMETERS = new JobParameters()
	static final TEST_JOB_INSTANCE = new JobInstance(TEST_JOBID_VALUE, TEST_JOB_PARAMETERS, TEST_JOBNAME_VALUE1)
	static final TEST_JOB_INSTANCE_LIST = [TEST_JOB_INSTANCE]
	static final TEST_JOB_NAME_LIST = [TEST_JOBNAME_VALUE1,TEST_JOBNAME_VALUE2]
	static final TEST_JOB_EXECUTION = new JobExecution(TEST_JOB_INSTANCE, TEST_JOBEXECUTIONID_VALUE)
	static final TEST_JOB_EXECUTION_LIST = [TEST_JOB_EXECUTION]
	def mockService
	public JobNameControllerUnitTests() {
		this(JobNameController)
	}
	public JobNameControllerUnitTests(Class clazz) {
		super(clazz)
	}
	protected void setUp() {
		super.setUp()
		mockController(JobNameController)
		mockService = mockFor(JobInstanceService)
	}
	
	protected void tearDown() {
		super.tearDown()
		mockService.verify()
	}
	private void demandGetJobNames() {
		mockService.demand.getJobNames(1..1) {-> return TEST_JOB_NAME_LIST }
		controller.jobInstanceService = mockService.createMock()
	}
	private void demandGetJobInstancesAndFindRunningJobs(def shouldStart=0) {
		mockService.demand.getJobInstances(1..1) {jobName, start, count ->
			assertEquals TEST_JOBNAME_VALUE1, jobName
			assertEquals shouldStart, start
			assertEquals 20, count
			return TEST_JOB_INSTANCE_LIST
		}
		mockService.demand.findRunningJobExecutions(1..1) {jobName ->
			assertEquals TEST_JOBNAME_VALUE1, jobName
			return []
		}
		controller.jobInstanceService = mockService.createMock()
		
	}
	private void demandGetJobInstanceAndFindJobExecutions() {
		mockService.demand.getJobInstance(1..1) {id ->
			assertEquals TEST_JOBID_VALUE, id
			return TEST_JOB_INSTANCE
		}
		mockService.demand.findJobExecutions(1..1) {it ->
			assertEquals TEST_JOB_INSTANCE, it
			return TEST_JOB_EXECUTION_LIST
		}
		
		controller.jobInstanceService = mockService.createMock()
		
	}
	private void demandGetJobExecution() {
		mockService.demand.getJobExecution(1..1) {id ->
			assertEquals TEST_JOBEXECUTIONID_VALUE, id
			return TEST_JOB_EXECUTION
		}    	
		controller.jobInstanceService = mockService.createMock()
		
		
	}
	void testCallIndex() {
		
		demandGetJobNames()
		
		def model = controller.index.call()
		
		JobNameControllerTestUtils.checkIndexModel(TEST_JOB_NAME_LIST, model)
	}
	
	void testCallShow() {
		
		demandGetJobInstancesAndFindRunningJobs()
		
		controller.params.id = TEST_JOBNAME_VALUE1
		
		def model = controller.show.call()
		
		assertEquals TEST_JOB_INSTANCE_LIST.size(), model.jobInstancesTotal
		JobNameControllerTestUtils.checkExpectedList(TEST_JOB_INSTANCE_LIST, model.jobInstances)
	}
	void testCallShowWithParams() {
		
		demandGetJobInstancesAndFindRunningJobs()
		
		controller.params.id = TEST_JOBNAME_VALUE1
		controller.params.max = 20
		
		
		def model = controller.show.call()
		
		assertEquals TEST_JOB_INSTANCE_LIST.size(), model.jobInstancesTotal
		JobNameControllerTestUtils.checkExpectedList(TEST_JOB_INSTANCE_LIST, model.jobInstances)
	}
	
	void testCallShowWithOffsetParams() {
		
		demandGetJobInstancesAndFindRunningJobs(1)		
		controller.params.id = TEST_JOBNAME_VALUE1
		controller.params.offset = 1
		
		
		def model = controller.show.call()
		
		assertEquals TEST_JOB_INSTANCE_LIST.size(), model.jobInstancesTotal
		JobNameControllerTestUtils.checkExpectedList(TEST_JOB_INSTANCE_LIST, model.jobInstances)
	}
	
	void testCallShowJobInstance() {
		demandGetJobInstanceAndFindJobExecutions()
		controller.params.id = TEST_JOBID_VALUE
		def model = controller.showJobInstance.call()
		assertEquals TEST_JOB_INSTANCE, model.jobInstance
		assertEquals TEST_JOB_EXECUTION_LIST, model.jobExecutions	    
	}
	
	void testCallShowJobInstanceWithNoId() {
		
		def model = controller.showJobInstance.call()
		assertEquals "Invalid Job Instance ID", controller.flash.message
		assertEquals "index", controller.redirectArgs.action
		
	}
	
	void testCallShowJobInstanceWithNonNumericId() {
		controller.params.id = 'NON_NUMERIC_STRING' 
		def model = controller.showJobInstance.call()
		assertEquals "Invalid Job Instance ID", controller.flash.message
		assertEquals "index", controller.redirectArgs.action
		
	}
	void testCallShowJobExecution() {
		
		demandGetJobExecution()
		controller.params.id = TEST_JOBEXECUTIONID_VALUE
		def model = controller.showJobExecution.call()
		assertEquals TEST_JOB_EXECUTION, model.jobExecution
		assertEquals TEST_JOB_INSTANCE, model.jobExecution.jobInstance
	}
	
	void testCallShowJobExecutionWithNoId() {
		
		def model = controller.showJobExecution.call()
		assertEquals "Invalid Job Execution ID", controller.flash.message
		assertEquals "index", controller.redirectArgs.action
		
	}
	void testCallShowJobExecutionWithInvalidId() {
		
		controller.params.id = 'NON_NUMERIC_STRING' 
		def model = controller.showJobExecution.call()
		assertEquals "Invalid Job Execution ID", controller.flash.message
		assertEquals "index", controller.redirectArgs.action
		
	}
}
