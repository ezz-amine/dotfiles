return {
  disableOrganizeImports = true,
  analysis = {
    typeCheckingMode = "basic",  -- or "strict"
    autoSearchPaths = true,
    diagnosticMode = "workspace",
    useLibraryCodeForTypes = true,
    diagnosticSeverityOverrides = {

      reportOptionalMemberAccess = "none",
      reportOptionalSubscript = "none",
      reportOptionalCall = "none",
      reportMissingImports = "error",
      reportGeneralTypeIssues = true,
      reportOptionalSubscript = false,
      reportOptionalMemberAccess = false,
      reportOptionalIterable = false,
      reportOptionalCall = false,
      reportUntypedFunctionDecorator = false,
      reportUntypedClassDecorator = false,
      reportPrivateUsage = "warning",
      reportUnusedImport = "warning",
      reportUnusedVariable = "warning",
      reportUnusedFunction = "warning",
      reportUnusedClass = "warning",
    },
  },
}