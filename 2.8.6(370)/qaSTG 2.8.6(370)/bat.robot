*** Settings ***
Library    AppiumLibrary
Library    Process
Library    OperatingSystem
Library    DateTime
 
Resource    ATV.resource
Suite Setup    에이닷 실행
Test Setup    에이닷 종료 후 재진입

*** Test Cases ***

45893 A. tv aar 이 포함 된 에이닷 앱 실행
    #1. 에이닷 실행 > "앱" 선택    /    1. "미디어" 메뉴 노출 시 pass
    
    [Tags]    General
    Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=${deviceName}    appPackage=${appPackage}    appActivity=${appActivity}    automationName=UIAutomator2    noReset=true
    Click Element    Xpath=//android.widget.TextView[@text="앱"]
    Sleep    1
    FOR  ${i}  IN RANGE    0    5    #미디어 메뉴까지 스와이프
        Swipe By Percent    50    90    50    10
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text="미디어"]
        Exit For Loop If    ${pass}
    END

45896 A. tv 진입
    #1. 에이닷 실행 > "앱" > "미디어" 선택    /    1. "미디어" 타이틀 노출 시 pass

    [Tags]    General
    미디어 메뉴 진입
    Sleep    5
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_title   

45897 미디어 종료
    #1. 에이닷 실행 > "앱" > "미디어" 선택
    #2. 뒤로가기(<) 버튼 선택    /    2. "미디어" 메뉴 노출 시 pass

    [Tags]    General
    미디어 메뉴 진입
    Sleep    5
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/iv_left_btn
    Click Element    com.skt.nugu.apollo.stg:id/iv_left_btn
    Sleep    2
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="미디어"]

45899 A. tv aar 이 포함 된 에이닷 앱 종료
    #1. 에이닷 실행 > "앱" > "미디어" 선택
    #2. 뒤로가기(<) 버튼 선택
    #3. 하드웨어 홈키 선택하여 백그라운드 상태
    #4. 하드웨어 메뉴키 선택하여 백그라운드 앱 목록 노출
    #5. 앱 [모두 닫기] 버튼 선택
    #6. 메뉴키 재선택    /    6. [모두 닫기] 버튼 미 노출 시 pass (열린 앱이 없을 경우, [모두 닫기] 버튼 노출되지 않음)

    [Tags]    General
    미디어 메뉴 진입
    Sleep    5
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/iv_left_btn
    Click Element    com.skt.nugu.apollo.stg:id/iv_left_btn
    Sleep    1
    Press Keycode    3    #홈키
    Sleep    2
    Press Keycode    187    #메뉴키
    Sleep    2
    Wait Until Element Is Visible    com.sec.android.app.launcher:id/clear_all_button
    Click Element    com.sec.android.app.launcher:id/clear_all_button    #앱 모두닫기
    Sleep    2
    Press Keycode    187    #메뉴키
    Sleep    1
    Page Should Not Contain Element    com.sec.android.app.launcher:id/clear_all_button
    Activate Application    ${appPackage}

45909 전체 채널 및 콘텐츠 재생 확인
    #1. 에이닷 실행 > "앱" > "미디어" 선택 > 최근 시청 카드플레이 진입
    #2. half 화면 탭하여 현재 runtime 값 체크
    #3. 5초 대기 후 다시 half 화면 탭하여 runtime 값 체크    /    6. 5초 전과 후의 runtime 값 변화 시 pass

    [Tags]    Player
    미디어 메뉴 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/cl_content_area
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/cl_content_area
    Sleep    5
    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
    Sleep    1
    ${play_runtime}    Get Element Attribute    com.skt.nugu.apollo.stg:id/tv_runtime    text
    Sleep    5
    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
    Sleep    1
    ${current_runtime}    Get Element Attribute    com.skt.nugu.apollo.stg:id/tv_runtime    text  
    Should Not Be Equal    ${play_runtime}    ${current_runtime}    #runtime 값 변화 확인

45914 play / puase 동작
    #1. 에이닷 실행 > "앱" > "미디어" 선택 > 최근 시청 카드플레이 진입
    #2. half 화면 탭 > pause 버튼 선택 시점의 runtime 값 체크
    #3. 5초 대기 후 다시 화면 탭하여 runtime 값 체크    /    3. pause 시점의 runtime 값과 5초 대기 후 runtime 값 일치 시 다음 단계  
    #4. half 화면 탭 > play 버튼 선택 선택 시점의 runtime 값 체크
    #5. 5초 대기 후 다시 화면 탭하여 runtime 값 체크    /    5. play 시점의 runtime 값과 5초 대기 후 runtime 값 변화 시 pass

    [Tags]    Player
    미디어 메뉴 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/cl_content_area
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/cl_content_area
    Sleep    5
    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
    Sleep    1
    Click Element    com.skt.nugu.apollo.stg:id/player_root    #pause
    Sleep    5
    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
    Sleep    1
    ${pause_runtime}    Get Element Attribute    com.skt.nugu.apollo.stg:id/tv_runtime    text
    Sleep    5
    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
    Sleep    1
    ${current_runtime}    Get Element Attribute    com.skt.nugu.apollo.stg:id/tv_runtime    text  
    Element Text Should Be    com.skt.nugu.apollo.stg:id/tv_runtime    ${pause_runtime}    ${current_runtime}    #pause 후 runtime 값 유지 확인
    Sleep    5
    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
    Sleep    1
    Click Element    com.skt.nugu.apollo.stg:id/iv_play_pause    #play
    Sleep    1
    ${play_runtime}    Get Element Attribute    com.skt.nugu.apollo.stg:id/tv_runtime    text
    Sleep    5
    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
    Sleep    1
    ${current_runtime}    Get Element Attribute    com.skt.nugu.apollo.stg:id/tv_runtime    text  
    Should Not Be Equal    ${play_runtime}    ${current_runtime}    #play 후 runtime 값 변화 확인

45915 탐색 동작 (Rew)
    #1. 에이닷 실행 > "앱" > "미디어" 선택 > 최근 시청 카드플레이 진입
    #2. 10초 대기 후 half 화면 탭 > 현재 runtime 값 체크
    #3. 10초 rewind 버튼 선택 후 runtime 값 체크    /    3. rewind 버튼 선택 전과 후의 runtime 값 약 10초 차이날 경우 pass
       
    [Tags]    Player
    미디어 메뉴 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/cl_content_area
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/cl_content_area
    Sleep    10
    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
    Sleep    1
    ${current_runtime}    Get Element Attribute    com.skt.nugu.apollo.stg:id/tv_runtime    text    #현재 runtime 체크
    
    Click Element    com.skt.nugu.apollo.stg:id/tv_rewind    #10초 rewind
    Sleep    1
    ${rewind_runtime}    Get Element Attribute    com.skt.nugu.apollo.stg:id/tv_runtime    text    #rewind 후 runtime 체크
    Sleep    2
    
    ${time_string1}    Set Variable    ${current_runtime.replace('- ', '')}       
    ${current_runtime_seconds}    Convert Time    ${time_string1}    
    ${time_string2}    Set Variable    ${rewind_runtime.replace('- ', '')}
    ${rewind_runtime_seconds}    Convert Time    ${time_string2} 

    ${time_diff}    Evaluate    ${rewind_runtime_seconds} - ${current_runtime_seconds}
    Should Be True  5 < ${time_diff} < 11
    
45916 탐색 동작 (FW)
    #1. 에이닷 실행 > "앱" > "미디어" 선택 > 최근 시청 카드플레이 진입
    #2. half 화면 탭 > 현재 runtime 값 체크
    #3. 10초 forward 버튼 선택 후 runtime 값 체크    /    3. forward 버튼 선택 전과 후의 runtime 값 약 10초 차이날 경우 pass

    [Tags]    Player
    미디어 메뉴 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/cl_content_area 
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/cl_content_area
    Sleep    5
    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
    Sleep    1
    ${current_runtime}    Get Element Attribute    com.skt.nugu.apollo.stg:id/tv_runtime    text    #현재 runtime 체크

    Click Element    com.skt.nugu.apollo.stg:id/tv_forward    #10초 forward
    Sleep    1
    ${forward_runtime}    Get Element Attribute    com.skt.nugu.apollo.stg:id/tv_runtime    text    #forward 후 runtime 체크
    Sleep    2

    ${time_string1}    Set Variable    ${current_runtime.replace('- ', '')}      
    ${current_runtime_seconds}    Convert Time    ${time_string1}    
    ${time_string2}    Set Variable    ${forward_runtime.replace('- ', '')}
    ${forward_runtime_seconds}    Convert Time    ${time_string2}   

    ${time_diff}    Evaluate    ${current_runtime_seconds} - ${forward_runtime_seconds}
    Should Be True  10 < ${time_diff} < 15

45917 재생 속도
    #1. 에이닷 실행 > "앱" > "미디어" 선택 > 최근 시청 카드플레이 진입
    #2. half 화면 탭 > 우측 상단 옵션(···) 버튼 선택    /    2. 속도 필드 Default x1.0 확인
    #3. 속도 필드 선택 > x0.8배속 선택 > [닫기] 버튼
    #4. 화면 탭 > 옵션 버튼 선택    /    4. 속도 필드 x0.8 변경 확인
    #5. 속도 필드 선택 > x1.2배속 선택 > [닫기] 버튼
    #6. 화면 탭 > 옵션 버튼 선택    /    6. 속도 필드 x1.2 변경 확인
    #7. 속도 필드 선택 > x1.5배속 선택 > [닫기] 버튼
    #8. 화면 탭 > 옵션 버튼 선택    /    8. 속도 필드 x1.5 변경 확인
    #9. 속도 필드 선택 > x2.0배속 선택 > [닫기] 버튼
    #10. 화면 탭 > 옵션 버튼 선택    /    8. 속도 필드 x2.0 변경 확인
    #11. [닫기] 버튼이 아닌 팝업 바깥영역 탭    /    11. 옵션 팝업 닫힘 확인될 경우 pass

    [Tags]    Player
    미디어 메뉴 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/cl_content_area 
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/cl_content_area
    Sleep    5
    FOR  ${i}  IN RANGE    0    5    
        Click Element    com.skt.nugu.apollo.stg:id/tabBorder    
        ${option_contain}=    Run Keyword And Return Status    Click Element    Xpath=//android.view.ViewGroup[@resource-id="com.skt.nugu.apollo.stg:id/detail_container"]/android.widget.ImageView[3]
        Exit For Loop If    ${option_contain}  
        Sleep    1
    END
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/speed_menu
    Element Text Should Be    id=com.skt.nugu.apollo.stg:id/tv_speed    x 1.0    #Default 1.0배속인지 확인
    Click Element    com.skt.nugu.apollo.stg:id/tv_speed
    Sleep    1
    Click Element    com.skt.nugu.apollo.stg:id/speed_08    #0.8배속으로 변경
    Click Element    com.skt.nugu.apollo.stg:id/btn_cancel
    FOR  ${i}  IN RANGE    0    5    
        Click Element    com.skt.nugu.apollo.stg:id/tabBorder    
        ${option_contain}=    Run Keyword And Return Status    Click Element    Xpath=//android.view.ViewGroup[@resource-id="com.skt.nugu.apollo.stg:id/detail_container"]/android.widget.ImageView[3]
        Exit For Loop If    ${option_contain}  
        Sleep    1
    END
    Sleep    1
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/speed_menu
    Element Text Should Be    id=com.skt.nugu.apollo.stg:id/tv_speed    x 0.8    #0.8배속인지 확인
    Click Element    com.skt.nugu.apollo.stg:id/tv_speed
    Sleep    1
    Click Element    com.skt.nugu.apollo.stg:id/speed_12    #1.2배속으로 변경
    Click Element    com.skt.nugu.apollo.stg:id/btn_cancel
    FOR  ${i}  IN RANGE    0    5    
        Click Element    com.skt.nugu.apollo.stg:id/tabBorder    
        ${option_contain}=    Run Keyword And Return Status    Click Element    Xpath=//android.view.ViewGroup[@resource-id="com.skt.nugu.apollo.stg:id/detail_container"]/android.widget.ImageView[3]
        Exit For Loop If    ${option_contain}  
        Sleep    1
    END
    Sleep    1
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/speed_menu
    Element Text Should Be    id=com.skt.nugu.apollo.stg:id/tv_speed    x 1.2    #1.2배속인지 확인
    Click Element    com.skt.nugu.apollo.stg:id/tv_speed
    Sleep    1
    Click Element    com.skt.nugu.apollo.stg:id/speed_15    #1.5배속으로 변경
    Click Element    com.skt.nugu.apollo.stg:id/btn_cancel
    FOR  ${i}  IN RANGE    0    5    
        Click Element    com.skt.nugu.apollo.stg:id/tabBorder    
        ${option_contain}=    Run Keyword And Return Status    Click Element    Xpath=//android.view.ViewGroup[@resource-id="com.skt.nugu.apollo.stg:id/detail_container"]/android.widget.ImageView[3]
        Exit For Loop If    ${option_contain}  
        Sleep    1
    END
    Sleep    1
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/speed_menu
    Element Text Should Be    id=com.skt.nugu.apollo.stg:id/tv_speed    x 1.5    #1.5배속인지 확인
    Click Element    com.skt.nugu.apollo.stg:id/tv_speed
    Sleep    1
    Click Element    com.skt.nugu.apollo.stg:id/speed_20    #2.0배속으로 변경
    Click Element    com.skt.nugu.apollo.stg:id/btn_cancel
    FOR  ${i}  IN RANGE    0    5    
        Click Element    com.skt.nugu.apollo.stg:id/tabBorder    
        ${option_contain}=    Run Keyword And Return Status    Click Element    Xpath=//android.view.ViewGroup[@resource-id="com.skt.nugu.apollo.stg:id/detail_container"]/android.widget.ImageView[3]
        Exit For Loop If    ${option_contain}  
        Sleep    1
    END
    Sleep    1
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/speed_menu
    Element Text Should Be    id=com.skt.nugu.apollo.stg:id/tv_speed    x 2.0    #2.0배속인지 확인
    Sleep    1
    Swipe By Percent    50    50    50    50    #팝업 바깥영역 선택
    Sleep    2
    Page Should Not Contain Element    com.skt.nugu.apollo.stg:id/btn_cancel    #팝업 닫힘 확인

45930 PIP 재생 > Player 재생 전환
    #1. 에이닷 실행 > "앱" > "미디어" 선택 > 최근 시청 카드플레이 진입
    #2. 하드웨어 홈키 입력    /    2. pip 전환
    #3. 앱 재진입    /    3. player 재생 화면 전환 확인될 경우 pass (상세 정보 버튼 노출 여부로 인식)

    [Tags]    Player
    미디어 메뉴 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/cl_content_area  
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/cl_content_area
    Sleep    5
    Press Keycode    3    #하드웨어 홈키
    Sleep    2
    Activate Application    ${appPackage}
    Sleep    2
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/player_root

45898 A. tv aar 이 포함 된 에이닷 앱 로그아웃
    #1. 에이닷 실행 > "앱" > 우상단 [설정] 버튼 선택
    #2. 개인 정보 > 로그아웃 > [확인] 버튼 선택    /    2. [홈으로 가기] 버튼 노출 확인 시 pass

    [Tags]    General
    Click Element    Xpath=//android.widget.Button[@content-desc="설정"]    #[설정] 버튼
    Sleep    1
    Click Element    Xpath=//android.widget.TextView[@text="개인 정보"]
    Sleep    1
    Click Element    Xpath=//android.widget.TextView[@text="로그아웃"]
    Sleep    1
    Click Element    com.skt.nugu.apollo.stg:id/positiveButtonText    #로그아웃 [확인] 버튼
    Sleep    1
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="홈으로 가기"]

상하좌우 스와이프
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. half 화면 탭 > full 화면 진입 > 우측 스와이프하여 추천정보 호출
    #3. 좌측 스와이프하여 추천정보 호출    /    3. 추천정보 내 프로그램명 변경 확인
    #4. 하단 스와이프하여 추천정보 호출
    #5. 상단 스와이프하여 추천정보 호출    /    5. 추천정보 내 채널명 변경 시 pass

    [Tags]    Player
    미디어 메뉴 진입
    full 화면 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    70    50    30    50    #우측 스와이프
    Sleep    1
    ${right_swipe}    Get Text    Xpath=//android.widget.TextView[@resource-id="com.skt.nugu.apollo.stg:id/tv_title"]
    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    30    50    70    50    #좌측 스와이프
    Sleep    1
    ${left_swipe}    Get Text    Xpath=//android.widget.TextView[@resource-id="com.skt.nugu.apollo.stg:id/tv_title"]
    Should Not Be Equal    ${right_swipe}    ${left_swipe}    #좌/우 스와이프 시, 프로그램명 변경 확인

    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    50    90    30    10    #하단 스와이프
    Sleep    1
    ${down_swipe}    Get Text    com.skt.nugu.apollo.stg:id/tv_channel_name
    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    50    10    30    90    #상단 스와이프
    Sleep    1
    ${up_swipe}    Get Text    com.skt.nugu.apollo.stg:id/tv_channel_name
    Should Not Be Equal    ${down_swipe}    ${up_swipe}    #하단/상단 스와이프 시, 프로그램명 변경 확인