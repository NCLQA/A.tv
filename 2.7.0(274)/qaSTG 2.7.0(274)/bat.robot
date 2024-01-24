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
    #1. 에이닷 실행 > "앱" 선택    /    1. "TV" 메뉴 노출 시 pass
    
    [Tags]    General
    Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=${deviceName}    appPackage=${appPackage}    appActivity=${appActivity}    automationName=UIAutomator2    noReset=true
    Click Element    Xpath=//android.widget.TextView[@text="앱"]
    Sleep    1
    FOR  ${i}  IN RANGE    0    5    #TV 메뉴까지 스와이프
        Swipe By Percent    50    90    50    10
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text="TV"]
        Exit For Loop If    ${pass}
    END   

45896 A. tv 진입
    #1. 에이닷 실행 > "앱" > "TV" 선택    /    1. "A.tv" 타이틀 노출 시 pass

    [Tags]    General
    TV 메뉴 진입
    Sleep    5
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/home_title   

45897 A. tv 종료
    #1. 에이닷 실행 > "앱" > "TV" 선택
    #2. 뒤로가기(<) 버튼 선택    /    2. "TV" 메뉴 노출 시 pass

    [Tags]    General
    TV 메뉴 진입
    Sleep    5
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/buttonExit
    Click Element    com.skt.nugu.apollo.stg:id/buttonExit
    Sleep    2
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="TV"]

45899 A. tv aar 이 포함 된 에이닷 앱 종료
    #1. 에이닷 실행 > "앱" > "TV" 선택
    #2. 뒤로가기(<) 버튼 선택
    #3. 하드웨어 홈키 선택하여 백그라운드 상태
    #4. 하드웨어 메뉴키 선택하여 백그라운드 앱 목록 노출
    #5. 앱 [모두 닫기] 버튼 선택
    #6. 메뉴키 재선택    /    6. [모두 닫기] 버튼 미 노출 시 pass (열린 앱이 없을 경우, [모두 닫기] 버튼 노출되지 않음)

    [Tags]    General
    TV 메뉴 진입
    Sleep    5
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/buttonExit
    Click Element    com.skt.nugu.apollo.stg:id/buttonExit
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

45932 자동 다운로드 설정 ON / OFF
    #0. 앱 설치 후 최초 진입 기준
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 우상단 다운로드 관리 버튼 선택    /    1. 자동 다운로드 토글 Default off 확인
    #2. 자동 다운로드 토글 선택    /    2. 자동 다운로드 사용 설정 완료 팝업 문구 확인
    #3. [확인] 버튼 선택    /    3. 토글 on 확인
    #4. 자동 다운로드 토글 재선택    /    4. 자동 다운로드 사용 설정 해제 완료 팝업 문구 확인
    #5. [확인] 버튼 선택    /    5. 토글 off 확인 
    #6. 자동 다운로드 토글 재선택    /    6. 토글 on 확인     

    [Tags]    Player
    TV 메뉴 진입
    Sleep    8
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/storageManager
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/storageManager    #다운로드 관리 진입 
    Sleep    5
    Element Text Should Be    com.skt.nugu.apollo.stg:id/textView24    자동 다운로드 사용

    ${false_checked}=    Get Element Attribute    com.skt.nugu.apollo.stg:id/switch_Download    checked
    Should Be Equal As Strings    ${false_checked}    false    #최초 진입 시, 자동 다운로드 사용 토글 off 확인

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/switch_Download    #토글 선택
    Sleep    1
    Element Text Should Be    com.skt.nugu.apollo.stg:id/title    자동 다운로드 사용 설정 완료
    Element Text Should Be    com.skt.nugu.apollo.stg:id/content    추천 영상 자동 다운로드가 안 되시나요? 배터리 사용량이 '최적화'로 설정되어 있는지, 기기를 충전 중인지 확인해 주세요.
    Element Text Should Be    com.skt.nugu.apollo.stg:id/subContent    설정 방법:설정>애플리케이션 정보>배터리>제한 없음으로 설정
    Click Element    com.skt.nugu.apollo.stg:id/confirmButton    #[확인] 버튼 선택
    Sleep    1
    ${true_checked}=    Get Element Attribute    com.skt.nugu.apollo.stg:id/switch_Download    checked
    Should Be Equal As Strings    ${true_checked}    true    #자동 다운로드 사용 토글 on 확인

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/switch_Download    #토글 선택
    Sleep    1
    Element Text Should Be    com.skt.nugu.apollo.stg:id/title    자동 다운로드 사용 설정 해제 완료
    Element Text Should Be    com.skt.nugu.apollo.stg:id/content    지금까지 다운로드된 영상은 이용 기간이 만료되면 자동으로 삭제되며, 직접 삭제하실 수도 있습니다.
    Click Element    com.skt.nugu.apollo.stg:id/confirmButton    #[확인] 버튼 선택
    Sleep    1
    ${false_checked}=    Get Element Attribute    com.skt.nugu.apollo.stg:id/switch_Download    checked
    Should Be Equal As Strings    ${false_checked}    false    #자동 다운로드 사용 토글 off 확인

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/switch_Download
    
45909 전체 채널 및 콘텐츠 재생 확인
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. half 화면 탭하여 현재 runtime 값 체크
    #3. 5초 대기 후 다시 half 화면 탭하여 runtime 값 체크    /    6. 5초 전과 후의 runtime 값 변화 시 pass

    [Tags]    Player
    TV 메뉴 진입
    Sleep    8
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/cl_content_area
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/cl_content_area
    Sleep    5
    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
    ${play_runtime}    Get Element Attribute    id=com.skt.nugu.apollo.stg:id/tv_runtime    text
    Sleep    5
    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
    ${current_runtime}    Get Element Attribute    id=com.skt.nugu.apollo.stg:id/tv_runtime    text  
    Should Not Be Equal    ${play_runtime}    ${current_runtime}    #runtime 값 변화 확인

45914 play / puase 동작
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. half 화면 탭 > pause 버튼 선택 시점의 runtime 값 체크
    #3. 5초 대기 후 다시 화면 탭하여 runtime 값 체크    /    3. pause 시점의 runtime 값과 5초 대기 후 runtime 값 일치 시 다음 단계  
    #4. half 화면 탭 > play 버튼 선택 선택 시점의 runtime 값 체크
    #5. 5초 대기 후 다시 화면 탭하여 runtime 값 체크    /    5. play 시점의 runtime 값과 5초 대기 후 runtime 값 변화 시 pass

    [Tags]    Player
    TV 메뉴 진입
    Sleep    8
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/cl_content_area
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/cl_content_area
    Sleep    5
    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
    Click Element    com.skt.nugu.apollo.stg:id/iv_play_pause    #pause
    ${pause_runtime}    Get Element Attribute    id=com.skt.nugu.apollo.stg:id/tv_runtime    text
    Sleep    5
    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
    ${current_runtime}    Get Element Attribute    id=com.skt.nugu.apollo.stg:id/tv_runtime    text  
    Element Text Should Be    id=com.skt.nugu.apollo.stg:id/tv_runtime    ${pause_runtime}    ${current_runtime}    #pause 후 runtime 값 유지 확인
    Sleep    3
    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
    Click Element    com.skt.nugu.apollo.stg:id/iv_play_pause    #play
    ${play_runtime}    Get Element Attribute    id=com.skt.nugu.apollo.stg:id/tv_runtime    text
    Sleep    5
    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
    ${current_runtime}    Get Element Attribute    id=com.skt.nugu.apollo.stg:id/tv_runtime    text  
    Should Not Be Equal    ${play_runtime}    ${current_runtime}    #play 후 runtime 값 변화 확인

45915 탐색 동작 (Rew)
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 10초 대기 후 half 화면 탭 > 현재 runtime 값 체크
    #3. 10초 rewind 버튼 선택 후 runtime 값 체크    /    3. rewind 버튼 선택 전과 후의 runtime 값 약 10초 차이날 경우 pass
       
    [Tags]    Player
    TV 메뉴 진입
    Sleep    8
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/cl_content_area
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/cl_content_area
    Sleep    10
    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
    ${current_runtime}    Get Element Attribute    id=com.skt.nugu.apollo.stg:id/tv_runtime    text    #현재 runtime 체크
    
    Click Element    com.skt.nugu.apollo.stg:id/tv_rewind    #10초 rewind
    ${rewind_runtime}    Get Element Attribute    id=com.skt.nugu.apollo.stg:id/tv_runtime    text    #rewind 후 runtime 체크
    Sleep    2
    
    ${time_string1}    Set Variable    ${current_runtime.replace('- ', '')}       
    ${current_runtime_seconds}    Convert Time    ${time_string1}    
    ${time_string2}    Set Variable    ${rewind_runtime.replace('- ', '')}
    ${rewind_runtime_seconds}    Convert Time    ${time_string2} 

    ${time_diff}    Evaluate    ${rewind_runtime_seconds} - ${current_runtime_seconds}
    Should Be True  5 < ${time_diff} < 11
    
45916 탐색 동작 (FW)
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. half 화면 탭 > 현재 runtime 값 체크
    #3. 10초 forward 버튼 선택 후 runtime 값 체크    /    3. forward 버튼 선택 전과 후의 runtime 값 약 10초 차이날 경우 pass

    [Tags]    Player
    TV 메뉴 진입
    Sleep    8
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/cl_content_area 
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/cl_content_area
    Sleep    5
    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
    ${current_runtime}    Get Element Attribute    id=com.skt.nugu.apollo.stg:id/tv_runtime    text    #현재 runtime 체크

    Click Element    com.skt.nugu.apollo.stg:id/tv_forward    #10초 forward
    ${forward_runtime}    Get Element Attribute    id=com.skt.nugu.apollo.stg:id/tv_runtime    text    #forward 후 runtime 체크
    Sleep    2

    ${time_string1}    Set Variable    ${current_runtime.replace('- ', '')}      
    ${current_runtime_seconds}    Convert Time    ${time_string1}    
    ${time_string2}    Set Variable    ${forward_runtime.replace('- ', '')}
    ${forward_runtime_seconds}    Convert Time    ${time_string2}   

    ${time_diff}    Evaluate    ${current_runtime_seconds} - ${forward_runtime_seconds}
    Should Be True  10 < ${time_diff} < 15

45917 재생 속도
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
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
    TV 메뉴 진입
    Sleep    8
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/cl_content_area 
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/cl_content_area
    Sleep    5
    FOR  ${i}  IN RANGE    0    5    
        Click Element    com.skt.nugu.apollo.stg:id/tabBorder    
        ${option_contain}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo.stg:id/iv_option_menu
        Exit For Loop If    ${option_contain}  
        Sleep    1
    END
    Sleep    1
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/speed_menu
    Element Text Should Be    id=com.skt.nugu.apollo.stg:id/tv_speed    x 1.0    #Default 1.0배속인지 확인
    Click Element    com.skt.nugu.apollo.stg:id/tv_speed
    Sleep    1
    Click Element    com.skt.nugu.apollo.stg:id/speed_08    #0.8배속으로 변경
    Click Element    com.skt.nugu.apollo.stg:id/btn_cancel
    FOR  ${i}  IN RANGE    0    5    
        Click Element    com.skt.nugu.apollo.stg:id/tabBorder    
        ${option_contain}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo.stg:id/iv_option_menu
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
        ${option_contain}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo.stg:id/iv_option_menu
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
        ${option_contain}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo.stg:id/iv_option_menu
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
        ${option_contain}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo.stg:id/iv_option_menu
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
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 하드웨어 홈키 입력    /    2. pip 전환
    #3. 앱 재진입    /    3. player 재생 화면 전환 확인될 경우 pass (상세 정보 버튼 노출 여부로 인식)

    [Tags]    Player
    TV 메뉴 진입
    Sleep    8
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/cl_content_area  
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/cl_content_area
    Sleep    2
    Press Keycode    3    #하드웨어 홈키
    Sleep    2
    Activate Application    ${appPackage}
    Sleep    2
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_detail_info_btn

45933 다운로드 용량 설정 (5GB~50GB)
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 우상단 다운로드 관리 버튼 선택
    #2. 용량 설정 - 버튼이 비활성화 되는 시점까지 반복 클릭    /    2. 설정 값 min 5 확인
    #3. 용량 설정 + 버튼이 비활성화 되는 시점까지 반복 클릭    /    3. 설정 값 max 50 확인 시 pass

    [Tags]    Player
    TV 메뉴 진입
    Sleep    8
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/storageManager
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/storageManager    #다운로드 관리 진입 
    Sleep    5

    FOR  ${i}  IN RANGE    0    50    # - 버튼이 비활성화 되는 시점까지 용량 설정 - 버튼 반복 클릭
        Click Element    com.skt.nugu.apollo.stg:id/ib_minus2
        ${false_enabled}=    Get Element Attribute    com.skt.nugu.apollo.stg:id/ib_minus2    enabled
        ${pass}=    Run Keyword And Return Status    Should Be Equal As Strings    ${false_enabled}    false
        Exit For Loop If    ${pass}
        Sleep    1
    END
    Sleep    1
    Element Text Should Be    com.skt.nugu.apollo.stg:id/tv_storage    5

    FOR  ${i}  IN RANGE    0    50    # + 버튼이 비활성화 되는 시점까지 용량 설정 + 버튼 반복 클릭
        Click Element    com.skt.nugu.apollo.stg:id/ib_plus2
        ${false_enabled}=    Get Element Attribute    com.skt.nugu.apollo.stg:id/ib_plus2    enabled
        ${pass}=    Run Keyword And Return Status    Should Be Equal As Strings    ${false_enabled}    false
        Exit For Loop If    ${pass}
        Sleep    1
    END
    Sleep    1
    Element Text Should Be    com.skt.nugu.apollo.stg:id/tv_storage    50

45918 다운로드 목록 UI 확인 (image / text) 
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 우상단 다운로드 관리 버튼 선택
    #                              /    1-1. 다운로드 콘텐츠 미존재 : "다운로드한 콘텐츠가 여기 표시됩니다." 문구 노출 시 pass 
    #                                   1-2. 다운로드 콘텐츠 존재 : 콘텐츠 썸네일 / 타이틀 / 용량 노출 시 pass

    [Tags]    Player
    TV 메뉴 진입
    Sleep    8
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/storageManager
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/storageManager    #다운로드 관리 진입 
    Sleep    5

    ${noti_status}=    Run Keyword And Return Status    Element Should Be Visible    com.skt.nugu.apollo.stg:id/tv_blank_noti
    IF    ${noti_status}
        Element Text Should Be    com.skt.nugu.apollo.stg:id/tv_blank_noti    다운로드한 콘텐츠가 없어요.
    ELSE
        Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/v_dim    #콘텐츠 이미지
        Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_title    #콘텐츠 타이틀
        Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_storage    #콘텐츠 용량
        Should Not Be Empty    Get text    com.skt.nugu.apollo.stg:id/tv_title   
        Should Not Be Empty    Get text    com.skt.nugu.apollo.stg:id/tv_storage
    END

45898 A. tv aar 이 포함 된 에이닷 앱 로그아웃
    #1. 에이닷 실행 > "앱" > 우상단 [설정] 버튼 선택
    #2. 개인 정보 > 로그아웃 > [확인] 버튼 선택    /    2. [홈으로 가기] 버튼 노출 확인 시 pass

    [Tags]    General
    Click Element    Xpath=//android.widget.ImageView[@content-desc="닫기"]    #[설정] 버튼
    Sleep    1
    Click Element    xPath=//android.widget.TextView[@text="개인 정보"]
    Sleep    1
    Click Element    xPath=//android.widget.TextView[@text="로그아웃"]
    Sleep    1
    Click Element    com.skt.nugu.apollo.stg:id/positiveButtonText    #로그아웃 [확인] 버튼
    Sleep    1
    Wait Until Element Is Visible    xPath=//android.widget.TextView[@text="홈으로 가기"]