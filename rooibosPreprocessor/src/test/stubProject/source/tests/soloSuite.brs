'@Only
'@TestSuite [VMT] VideoModuleTests

'@Setup
function VMT_Setup()
  ? "setp"
end function

'@TearDown
function VMT_TearDown()
  ? "tearDown"
end function


'@BeforeEach
function VMT_BeforeEach()
  m.constants = {}
  m.httpService = {}
  
  m.module = VideoModule(m.constants, m.httpService)
end function

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests constructor
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test basic constructor values
function VMT__constructor_basic() as void
	m.AssertEqual(m.module.constants_, m.constants)
	m.AssertEqual(m.module.httpService_, m.httpService)
end function


'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests getVideos
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


'@BeforeEach
function VMT_GetVideosBeforeEach()
    ? "gtVideosBeforeEach"
end function

'@AfterEach
function VMT_GetvideosAfterEach()
    ? "getvideosAfterEach"
end function


'@Test basic test
'@Params[3, "mp4", ["video_0", "video_1", "video_2"]]
'@Params[2, "mpg", ["video_0", "video_1"]]
'@Params[1, "vp8", ["video_0"]]
function VMT__getVideos_basic(expectedCount, videoType, videoIds) as void
	videos = m.module.getVideos(videoType)

	m.AssertArrayCount(videos, expectedCount)
	m.AssertArrayContainsAAs(videos, [{"type":videoType}])
	
	expectedIds = []
	for each id in videoIds
	  expectedIds.push({"id": id})
	end for
	
	m.AssertArrayContainsAAs(videos, expectedIds)
end function

'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
'@It tests getVideosRealExample
'+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

'@Test basic test
'@Params["mp4", ["a", "b", "c"]]
'@Params["mp3", ["a", "b", "c", "d", "e"]]
function VMT__getVideosRealExample_basic(videoType, returnedJson) as void
  getjsonMock = m.expectOnce(m.httpService, "getJson", [m.ignoreValue, videoType], returnedJson, true)

  videos = m.module.getVideosRealExample(videoType)
  
  m.AssertArrayContainsSubset(videos, returnedJson)
end function





