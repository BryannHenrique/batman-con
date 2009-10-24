package com.orangeandbronze.batchmon

import grails.test.*

class JobNameControllerTests extends ControllerUnitTestCase {
	def jobInstanceService
    protected void setUp() {
        super.setUp()
        controller.jobInstanceService = jobInstanceService
    }

    protected void tearDown() {
        super.tearDown()
    }
    
    void testServiceSetup() {
    	assertNotNull jobInstanceService
    }

    void testControllerSetup() {
    	assertNotNull controller
    	assertNotNull controller.jobInstanceService
    }
    

    void testListJobNames() {
    	def model = controller.index.call()
    	assertNotNull model
    	assertNotNull model.jobNames
    	assertEquals 1, model.jobNamesTotal
    }
    void testShowJobExecution() {
    	controller.params.id = 44
    	def model = controller.showJobExecution.call()
    	assertNotNull model.jobExecution
    	assertNotNull model.jobExecution.jobInstance
    	assertEquals model.jobExecution.jobInstance, model.jobInstance
    	assertEquals 39, model.jobInstance.id
    }
}
