CREATE TABLE AuditLogsResults (
    TimeGenerated DATETIME,
    ActivityDisplayName NVARCHAR(MAX),
    InitiatedBy_user_id NVARCHAR(MAX),
    InitiatedBy_user_displayName NVARCHAR(MAX),
    InitiatedBy_user_userPrincipalName NVARCHAR(MAX),
    TargetResources_0_displayName NVARCHAR(MAX),
    TargetResources_0_id NVARCHAR(MAX)
);