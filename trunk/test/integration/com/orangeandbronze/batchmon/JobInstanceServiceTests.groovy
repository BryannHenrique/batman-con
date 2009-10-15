package com.orangeandbronze.batchmon

import grails.test.*
import org.springframework.batch.core.JobParameters
import org.springframework.batch.core.JobInstance

class JobInstanceServiceTests extends GrailsUnitTestCase {
	static final TESTDB_JOBNAME_VALUE = 'spam'
	static final TESTDB_JOBID_VALUE = 39L
	static final TEST_START_VALUE = 0
	static final TEST_PAGE_VALUE = 20
	def jobInstanceService
	
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testAccessService() {
    	assertNotNull jobInstanceService
    }
    void testServiceSetup() {
    	assertNotNull jobInstanceService.jobInstanceDao
    }
    void testGetJobNames() {
    	def expectedResult = [TESTDB_JOBNAME_VALUE]
    	def jobNames = jobInstanceService.jobNames
    	assertNotNull jobNames
    	JobNameControllerTestUtils.checkExpectedList(expectedResult, jobNames)
    }
    void testGetJobInstances() {
    	def expectedResult =  [new JobInstance(TESTDB_JOBID_VALUE,new JobParameters(),TESTDB_JOBNAME_VALUE)]
    	def jobInstances = jobInstanceService.getJobInstances(TESTDB_JOBNAME_VALUE, TEST_START_VALUE, TEST_PAGE_VALUE)
    	
    	assertNotNull jobInstances
    	JobNameControllerTestUtils.checkExpectedList(expectedResult, jobInstances)
    }
}
