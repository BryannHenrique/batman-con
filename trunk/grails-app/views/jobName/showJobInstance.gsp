<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Show Job Instance</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="index">Batch Jobs</g:link></span>
            <span class="menuButton"><g:link class="list" action="show" id="${jobInstance.jobName}" >Batch Job: ${jobInstance.jobName}</g:link></span>
        </div>
        <div class="body">
            <h1>Batch Job Instance</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>

                    
                        <tr class="prop">
                            <td valign="top" class="name">Id:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:jobInstance, field:'id')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Name:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:jobInstance, field:'jobName')}</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Parameters:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:jobInstance, field:'jobParameters')}</td>
                            
                        </tr>
                    
              
                    </tbody>
                </table>
            </div>
            <h1>Batch Parameters</h1>
	        <g:set var="parameters" value="${jobInstance.jobParameters.parameters}" />
            
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="key" title="${message(code: 'jobParameters.key.label', default: 'Key')}" />
                            <g:sortableColumn property="type" title="${message(code: 'jobParameters.type.label', default: 'Parameter')}" />
                            <g:sortableColumn property="value" title="${message(code: 'jobParameters.value.label', default: 'Value')}" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${parameters}" status="i" var="parameterEntry">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td>${fieldValue(bean:parameterEntry, field:'key')}</td>             
                            <td>${fieldValue(bean:parameterEntry.value, field:'type')}</td>             
                            <td>${fieldValue(bean:parameterEntry.value, field:'value')}</td>             
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            
            <h1>Batch Executions</h1>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="id" title="${message(code: 'runningJobExecution.id.label', default: 'Execution ID')}" />
                            <g:sortableColumn property="createTime" title="${message(code: 'jobExecution.createTime.label', default: 'Create Time')}" />
                            <g:sortableColumn property="startTime" title="${message(code: 'jobExecution.startTime.label', default: 'Start Time')}" />
                            <g:sortableColumn property="endTime" title="${message(code: 'jobExecution.endTime.label', default: 'End Time')}" />
                            <g:sortableColumn property="status" title="${message(code: 'jobExecution.status.label', default: 'Status')}" />
                            <g:sortableColumn property="lastUpdated" title="${message(code: 'jobExecution.lastUpdated.label', default: 'Last Updated')}" />
                          
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${jobExecutions}" status="i" var="jobExecution">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="showJobExecution" id="${jobExecution.id}">${fieldValue(bean:jobExecution, field:'id')}</g:link></td>
                            <td>${fieldValue(bean:jobExecution, field:'createTime')}</td>             
                            <td>${fieldValue(bean:jobExecution, field:'startTime')}</td>             
                            <td>${fieldValue(bean:jobExecution, field:'endTime')}</td>             
                            <td>${fieldValue(bean:jobExecution, field:'status')}</td>             
                            <td>${fieldValue(bean:jobExecution, field:'lastUpdated')}</td>             
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${jobExecutionsTotal}" />
            </div>
        </div>
    </body>
</html>
