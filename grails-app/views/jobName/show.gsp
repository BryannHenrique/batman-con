<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'jobInstances.label', default: 'Batch Job Instances')}" />
        <g:set var="jobName" value="${message(code: 'jobNames.label', default: 'Batch Jobs')}" />
        <g:set var="runningJobExecution" value="${message(code: 'runningJobExecution.label', default: 'Running Batch Jobs')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir: '')}">Home</a></span>
            <span class="menuButton"><g:link action="index" >${jobName}</g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <h2>${jobName}:${params.id}</h2>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="id" title="${message(code: 'batchJobInstance.id.label', default: 'Instance Id')}" />
                          
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${jobInstances}" status="i" var="jobInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="showJobInstance" id="${jobInstance.id}">${jobInstance.id}</g:link></td>
                                          
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${jobInstancesTotal}" />
            </div>
            <h2>${runningJobExecution}:${params.id}</h2>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="id" title="${message(code: 'runningJobExecution.id.label', default: 'Execution ID')}" />
                            <g:sortableColumn property="jobId" title="${message(code: 'batchJobInstance.id.label', default: 'Instance Id')}" />
                            <g:sortableColumn property="createTime" title="${message(code: 'jobExecution.createTime.label', default: 'Create Time')}" />
                            <g:sortableColumn property="startTime" title="${message(code: 'jobExecution.startTime.label', default: 'Start Time')}" />
                            <g:sortableColumn property="status" title="${message(code: 'jobExecution.status.label', default: 'Status')}" />
                            <g:sortableColumn property="lastUpdated" title="${message(code: 'jobExecution.lastUpdated.label', default: 'Last Updated')}" />
                          
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${runningJobs}" status="i" var="jobExecution">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="showJobExecution" id="${jobExecution.id}">${fieldValue(bean:jobExecution, field:'id')}</g:link></td>
                            <td><g:link action="showJobInstance" id="${jobExecution.jobInstance.id}">${fieldValue(bean:jobExecution.jobInstance, field:'id')}</g:link></td>
                            <td>${fieldValue(bean:jobExecution, field:'createTime')}</td>             
                            <td>${fieldValue(bean:jobExecution, field:'startTime')}</td>             
                            <td>${fieldValue(bean:jobExecution, field:'status')}</td>             
                            <td>${fieldValue(bean:jobExecution, field:'lastUpdated')}</td>             
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${runningJobsTotal}" />
            </div>
        </div>
    </body>
</html>
