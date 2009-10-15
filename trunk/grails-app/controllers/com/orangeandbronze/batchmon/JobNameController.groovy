package com.orangeandbronze.batchmon

class JobNameController {
	def jobInstanceService
    def index = { 
		def jobNames = jobInstanceService.jobNames
		[jobNames:jobNames, jobNamesTotal: jobNames.size()]
	}
	def show = {
		params.max = params.max?: 20
		params.offset = params.offset?: 0
		def jobInstances = jobInstanceService.getJobInstances(params.id, params.offset, params.max)
		def runningJobs = jobInstanceService.findRunningJobExecutions(params.id)
		return [jobInstances:jobInstances, jobInstancesTotal: jobInstances.size(), runningJobs:runningJobs, runningJobsTotal: runningJobs.size()]
	}
	def showJobInstance = {
		if (!params.id) {
			flash.message = "Invalid Job Instance ID"
			redirect(action:"index")
			return
		}
		def id = null
		try {
			id = Long.parseLong(params.id.toString())			
		}
		catch (NumberFormatException e) {
			flash.message = "Invalid Job Instance ID"
			redirect(action:"index")
			return
		}
		def jobInstance = jobInstanceService.getJobInstance(id)
		def jobExecutions = jobInstanceService.findJobExecutions(jobInstance)
		return [jobInstance:jobInstance, jobExecutions:jobExecutions, jobExecutionsTotal:jobExecutions.size()]
	}
	def showJobExecution = {
		if (!params.id) {
			flash.message = "Invalid Job Execution ID"
			redirect(action:"index")
			return
		}
		def id = null
		try {
			id = Long.parseLong(params.id.toString())			
		}
		catch (NumberFormatException e) {
			flash.message = "Invalid Job Execution ID"
			redirect(action:"index")
			return
		}
		def jobExecution = jobInstanceService.getJobExecution(id)
		return [jobExecution:jobExecution, jobInstance:jobExecution.jobInstance]
	}
}


