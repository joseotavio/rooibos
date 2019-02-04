
function RBS_ItG_GetTestCases(group) as object
  if (group.hasSoloTests = true)
    return group.soloTestCases
  else
    return group.testCases
  end if
end function

function RBS_ItG_GetRunnableTestSuite(group) as object
  testCases = RBS_ItG_GetTestCases(group)

  runnableSuite = BaseTestSuite()
  runnableSuite.name = group.name
  runnableSuite.isLegacy = group.isLegacy = true
  if group.testCaseLookup = invalid
    group.testCaseLookup = {}
  end if

  for each testCase in testCases
    name = testCase.name
    if (testCase.isSolo = true)
      name += " [SOLO] "
    end if
    testFunction = RBS_CMN_GetFunction(group.filename, testCase.funcName)
    runnableSuite.addTest(name, testFunction, testCase.funcName)
    group.testCaseLookup[name] = testCase
  end for

  runnableSuite.SetUp = RBS_CMN_GetFunction(group.filename, group.setupFunctionName)
  runnableSuite.TearDown =  RBS_CMN_GetFunction(group.filename, group.teardownFunctionName)
  runnableSuite.BeforeEach =  RBS_CMN_GetFunction(group.filename, group.beforeEachFunctionName)
  runnableSuite.AfterEach =  RBS_CMN_GetFunction(group.filename, group.afterEachFunctionName)

  return runnableSuite
end function
