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
}
