*** Settings ***
Library    AppiumLibrary
Library    Process
Library    OperatingSystem
Library    DateTime

Resource    ATV.resource
Suite Setup    에이닷 실행
Test Setup    에이닷 종료 후 재진입

*** Test Cases ***

채널 정보 확인
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. half player 상태의 채널명 확인
    #3. 화면 탭 > full player 진입 > 우측 스와이프하여 추천정보 호출
    #4. full player 상태의 채널명 확인    /    4. half 및 full player 채널명 동일하게 노출 시 pass 

    [Tags]    Player
    Click Element    Xpath=//android.widget.TextView[@text="TV"]
    Sleep    8
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/cl_content_area
    Sleep    1
    ${half}    Get Text    com.skt.nugu.apollo.stg:id/tv_channel_name    #half player 채널명 저장
    FOR  ${i}  IN RANGE    0    10
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
        ${pass}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo.stg:id/iv_full
        Exit For Loop If    ${pass}
        Sleep    1
    END
    Sleep    2
    Swipe By Percent    70    50    30    50    #추천정보 호출
    Sleep    1
    ${full}    Get Text    com.skt.nugu.apollo.stg:id/tv_channel_name    #full player 채널명 저장
    Should Be Equal    ${half}    ${full}    #full player 진입 전 후 채널명 동일한지 확인

캐릭터
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입 > 우측 스와이프하여 추천정보 호출    /    2. 추천정보 내 캐릭터 이미지 노출 시 pass 

    [Tags]    Player
    full 화면 진입
    Swipe By Percent    70    50    30    50    #추천정보 호출
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/iv_character

콘텐츠 기본 정보
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입 > 우측 스와이프하여 추천정보 호출    /    2. 추천정보 내 러닝타임, 장르, 상세정보 버튼 노출 시 pass

    [Tags]    Player
    full 화면 진입
    FOR  ${i}  IN RANGE    0    5    #세 가지 요소가 모두 보일 때까지 스와이프 반복
        Swipe By Percent    70    50    30    50    #추천정보 호출
        ${runtime_contain}=    Run Keyword And Return Status    Wait Until Page Contains Element    com.skt.nugu.apollo.stg:id/tv_runtime
        ${genre_contain}=    Run Keyword And Return Status    Wait Until Page Contains Element    com.skt.nugu.apollo.stg:id/tv_genre
        ${info_contain}=    Run Keyword And Return Status    Wait Until Page Contains Element    com.skt.nugu.apollo.stg:id/iv_info
        Exit For Loop If    ${runtime_contain} and ${genre_contain} and ${info_contain}
        Sleep    1
    END

다운로드 관리 버튼 선택
    #1. 에이닷 실행 > "앱" > "TV" 선택
    #2. 우상단 다운로드 관리 버튼 선택    /    2. '다운로드 관리' 타이틀 노출 시 pass

    [Tags]    Player
    Click Element    Xpath=//android.widget.TextView[@text="TV"]
    Sleep    8
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/storageManager
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/storageManager 
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/textView    #다운로드 관리 타이틀 노출 확인

추천 정보 노출 상태에서 상세정보 보기 진입
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입 > 우측 스와이프하여 추천정보 호출
    #3. 추천정보 내 [상세 정보] 버튼 선택    /    3. '상세 정보' 타이틀 노출 시 pass

    [Tags]    Player
    full 화면 진입
    FOR  ${i}  IN RANGE    0    5    #상세정보 버튼 인식 시점까지 추천정보 호출 반복
        Swipe By Percent    70    50    30    50
        ${info_contain}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo.stg:id/iv_info
        Exit For Loop If    ${info_contain}
        Sleep    1
    END
    Sleep    1
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_view    #상세정보 타이틀 노출 확인

플레이어 컴포넌트 노출 상태에서 상세정보 보기 진입
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 화면 탭하여 컴포넌트 호출 > [상세정보] 버튼 선택    /    3. '상세 정보' 타이틀 노출 시 pass

    [Tags]    Player
    full 화면 진입
    FOR  ${i}  IN RANGE    0    5    #상세정보 버튼 인식 시점까지 컴포넌트 호출 반복
        Click Element    class=android.view.View
        ${info_contain}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo.stg:id/iv_info
        Exit For Loop If    ${info_contain}
        Sleep    1
    END
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_view    #상세정보 타이틀 노출 확인

상세정보 > 닫기 버튼 선택
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 화면 탭하여 컴포넌트 호출 > [상세정보] 버튼 선택
    #4. 닫기(X) 버튼 선택    /    4. 상세정보 닫힘 여부 확인
    #5. 화면 탭하여 컴포넌트 호출 > [상세정보] 버튼 선택
    #6. 닫기 버튼이 아닌 상세정보 영역 외 터치    /    6. 상세정보 닫힘 여부 확인

    [Tags]    Player
    full 화면 진입
    FOR  ${i}  IN RANGE    0    5    #상세정보 버튼 인식 시점까지 컴포넌트 호출 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${info_contain}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo.stg:id/iv_info
        Exit For Loop If    ${info_contain}
        Sleep    1
    END
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_view
    Click Element    com.skt.nugu.apollo.stg:id/iv_close    #닫기 버튼 선택
    Sleep    1
    Page Should Not Contain Element    com.skt.nugu.apollo.stg:id/tv_view    #상세정보 닫힘 여부 확인

    FOR  ${i}  IN RANGE    0    5    #상세정보 버튼 인식 시점까지 컴포넌트 호출 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${info_contain}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo.stg:id/iv_info
        Exit For Loop If    ${info_contain}
        Sleep    1
    END
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_view
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View    #상세보기 영역 외 터치
    Sleep    1
    Page Should Not Contain Element    com.skt.nugu.apollo.stg:id/tv_view    #상세정보 닫힘 여부 확인

상세정보 > 콘텐츠 타이틀 정보
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 화면 탭하여 컴포넌트 호출 > [상세정보] 버튼 선택    /    3. 콘텐츠 타이틀 노출 시 pass

    [Tags]    Player
    full 화면 진입
    Click Element    class=android.view.View
    Click Element    com.skt.nugu.apollo.stg:id/iv_info
    Sleep    1
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_title    #타이틀 확인

상세정보 > 콘텐츠 기본 정보
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 화면 탭하여 컴포넌트 호출 > [상세정보] 버튼 선택    /    3. 콘텐츠 등급, 러닝타임, 장르 노출 시 pass

    [Tags]    Player
    full 화면 진입
    Click Element    class=android.view.View
    Click Element    com.skt.nugu.apollo.stg:id/iv_info
    Sleep    1
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/iv_rating    #등급
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_runtime    #러닝타임
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_genre    #장르

A. tv 종료
    #1. 에이닷 실행 > "앱" > "TV" 선택
    #2. 좌상단 나가기(<) 버튼 선택    /    2. "TV" 메뉴 노출 시 pass

    [Tags]    Player
    Click Element    Xpath=//android.widget.TextView[@text="TV"]
    Sleep    5
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/buttonExit
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/buttonExit
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="TV"]

편성표 > 닫기 버튼 선택
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 화면 탭하여 컴포넌트 호출 > 우상단 편성표 버튼 선택    /    3. 편성 정보 타이틀 노출 확인
    #4. 편성표 내 우상단 닫기(X) 버튼 선택    /    4. 편성표 종료 시 pass

    [Tags]    Player
    full 화면 진입
    Click Element    class=android.view.View
    Click Element    com.skt.nugu.apollo.stg:id/iv_schedule
    Sleep    1
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/labelScheduleInfo    #편성표 진입 확인
    Click Element    com.skt.nugu.apollo.stg:id/closeButton    #닫기 버튼
    Page Should Not Contain Element   com.skt.nugu.apollo.stg:id/labelScheduleInfo   #편성표 종료 여부 확인 

편성표 > 편성 일자 정보(ON AIR & Live 채널)
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 화면 탭하여 컴포넌트 호출 > 우상단 편성표 버튼 선택
    #4. live 또는 on air 태그 노출시점까지 스크롤    /    4. NOW 태그 및 프로그램 시간 노출 시 pass

    [Tags]    Player
    full 화면 진입
    Click Element    class=android.view.View
    Click Element    com.skt.nugu.apollo.stg:id/iv_schedule    #편성표 진입
    Sleep    1
    FOR  ${i}  IN RANGE    0    10    #live 또는 on air 태그 노출시점까지 스크롤
        Swipe By Percent    50    90    50    10
        ${pass}=    Run Keyword And Return Status    Wait Until Page Contains Element    com.skt.nugu.apollo.stg:id/typeImg
        Exit For Loop If    ${pass}
        Sleep    1
    END
    Sleep    1
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/nowIndicator    #NOW 태그 노출 확인
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/time    #프로그램 시간 노출 확인

편성표 > 편성 시간 정보
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 화면 탭하여 컴포넌트 호출 > 우상단 편성표 버튼 선택
    #4. live 또는 on air 태그 노출시점까지 스크롤    /    4. 프로그램 시간이 'dd:dd - dd:dd' 형식에 일치 시 pass

    [Tags]    Player
    full 화면 진입
    Click Element    class=android.view.View
    Click Element    com.skt.nugu.apollo.stg:id/iv_schedule    #편성표 진입
    Sleep    1
    FOR  ${i}  IN RANGE    0    10    #live 또는 on air 태그 노출시점까지 스크롤
        Swipe By Percent    50    90    50    10
        ${pass}=    Run Keyword And Return Status    Wait Until Page Contains Element    com.skt.nugu.apollo.stg:id/typeImg
        Exit For Loop If    ${pass}
        Sleep    1
    END
    Sleep    1
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/time
    ${time_text}=    Get Text    com.skt.nugu.apollo.stg:id/time
    Should Match Regexp    ${time_text}    ^\\d{2}:\\d{2} ~ \\d{2}:\\d{2}$    #프로그램 시간이 형식에 맞는지 확인

컴포넌트 노출 상태로 전환
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 스와이프 > 추천 정보 호출 상태에서 화면 탭    /    3. 컴포넌트 노출
    #4. 5초 대기 후 컴포넌트 미 노출 상태 > 화면 탭    /    4. 컴포넌트 노출 시 pass

    [Tags]    Player
    full 화면 진입
    Swipe By Percent    70    50    30    50
    Click Element    class=android.view.View    #추천 정보 노출 상태에서 화면 탭
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/iv_play_pause    #컴포넌트 노출 확인
    Sleep    5
    Click Element    class=android.view.View    #컴포넌트 미노출 상태에서 화면 탭
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/iv_play_pause    #컴포넌트 노출 확인

컴포넌트 노출 상태에서 제스처 동작
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 화면 탭 > 컴포넌트 노출 상태에서 우측 스와이프
    #4. 화면 탭 > 컴포넌트 노출 상태에서 좌측 스와이프
    #5. 화면 탭 > 컴포넌트 노출 상태에서 하단 스와이프
    #6. 화면 탭 > 컴포넌트 노출 상태에서 상단 스와이프

    [Tags]    Player
    full 화면 진입
    Click Element    class=android.view.View    #컴포넌트 호출
    Swipe By Percent    70    50    30    50    #우측 스와이프
    Click Element    class=android.view.View    #컴포넌트 호출
    Swipe By Percent    30    50    70    50    #좌측 스와이프
    Click Element    class=android.view.View    #컴포넌트 호출
    Swipe By Percent    50    90    50    10    #하단 스와이프
    Click Element    class=android.view.View    #컴포넌트 호출
    Swipe By Percent    50    10    50    90    #상단 스와이프

일반 채널 (Seeking 가능) > 채널, 콘텐츠 정보
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 화면 탭하여 컴포넌트 호출    /    3. 채널명, 타이틀 노출
    #4. 3초후 컴포넌트 재호출 > 상세정보 버튼 선택    /    4. '상세 정보' 타이틀 노출 시 pass

    [Tags]    Player
    full 화면 진입
    FOR  ${i}  IN RANGE    0    10    #채널명, 타이틀 인식 시점까지 컴포넌트 호출 반복
        Click Element    class=android.view.View
        ${name_pass}=    Run Keyword And Return Status    Wait Until Page Contains Element    com.skt.nugu.apollo.stg:id/tv_channel_name
        ${title_pass}=    Run Keyword And Return Status    Wait Until Page Contains Element    com.skt.nugu.apollo.stg:id/tv_title
        Exit For Loop If    ${name_pass} and ${title_pass}
        Sleep    1
    END
    Sleep    3
    Click Element    class=android.view.View    #컴포넌트 재호출
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/iv_info
    Click Element    com.skt.nugu.apollo.stg:id/iv_info    #상세 정보 버튼 선택
    Sleep    1
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_view    #상세 정보 노출 확인  

플레이어 컴포넌트 > 속도 조절 버튼 노출 확인
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 화면 탭하여 컴포넌트 호출 > 우측 하단 옵션(···) 버튼 선택    /    3. Default 속도 1.0배속 노출
    #4. [속도] 설정 진입 > 0.8배속으로 변경 > 닫기(X) 버튼 선택
    #5. 컴포넌트 재호출 > 옵션(···) 버튼 선택    /    5. 속도 0.8배속 변경 노출
    #6. [속도] 설정 진입 > 1.2배속으로 변경 > 닫기(X) 버튼 선택
    #7. 컴포넌트 재호출 > 옵션(···) 버튼 선택    /    7. 속도 1.2배속 변경 노출  
    #8. [속도] 설정 진입 > 1.5배속으로 변경 > 닫기(X) 버튼 선택
    #9. 컴포넌트 재호출 > 옵션(···) 버튼 선택    /    9. 속도 1.5배속 변경 노출
    #10. [속도] 설정 진입 > 2.0배속으로 변경 > 닫기(X) 버튼 선택
    #11. 컴포넌트 재호출 > 옵션(···) 버튼 선택    /    11. 속도 2.0배속 변경 노출
    #12. [속도] 설정 진입 > 1.0배속으로 변경 > 팝업 바깥부분 탭
    #13. 컴포넌트 재호출 > 옵션(···) 버튼 선택    /    13. 속도 1.0배속 변경 노출

    [Tags]    Player
    full 화면 진입
    FOR  ${i}  IN RANGE    0    5
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${more_contain}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo.stg:id/cl_more
        Exit For Loop If    ${more_contain}
        Sleep    1
    END
    Element Text Should Be    com.skt.nugu.apollo.stg:id/tv_speed    속도 (1.0x)    #Default 1.0배속인지 확인
    Click Element    com.skt.nugu.apollo.stg:id/tv_speed
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_title    #배속 설정 진입 확인
    Click Element    com.skt.nugu.apollo.stg:id/tv_08    #0.8배속으로 변경
    Click Element    com.skt.nugu.apollo.stg:id/iv_close

    FOR  ${i}  IN RANGE    0    5
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${more_contain}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo.stg:id/cl_more
        Exit For Loop If    ${more_contain}  
        Sleep    1
    END
    Element Text Should Be    com.skt.nugu.apollo.stg:id/tv_speed    속도 (0.8x)    #0.8배속인지 확인
    Click Element    com.skt.nugu.apollo.stg:id/tv_speed
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_title    #배속 설정 진입 확인
    Click Element    com.skt.nugu.apollo.stg:id/tv_12    #1.2배속으로 변경
    Click Element    com.skt.nugu.apollo.stg:id/iv_close

    FOR  ${i}  IN RANGE    0    5
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${more_contain}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo.stg:id/cl_more
        Exit For Loop If    ${more_contain}
        Sleep    1
    END    
    Element Text Should Be    com.skt.nugu.apollo.stg:id/tv_speed    속도 (1.2x)    #1.2배속인지 확인
    Click Element    com.skt.nugu.apollo.stg:id/tv_speed
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_title    #배속 설정 진입 확인
    Click Element    com.skt.nugu.apollo.stg:id/tv_15    #1.5배속으로 변경
    Click Element    com.skt.nugu.apollo.stg:id/iv_close

    FOR  ${i}  IN RANGE    0    5
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${more_contain}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo.stg:id/cl_more
        Exit For Loop If    ${more_contain}
        Sleep    1
    END    
    Element Text Should Be    com.skt.nugu.apollo.stg:id/tv_speed    속도 (1.5x)    #1.5배속인지 확인
    Click Element    com.skt.nugu.apollo.stg:id/tv_speed
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_title    #배속 설정 진입 확인
    Click Element    com.skt.nugu.apollo.stg:id/tv_20    #2.0배속으로 변경
    Click Element    com.skt.nugu.apollo.stg:id/iv_close

    FOR  ${i}  IN RANGE    0    5
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${more_contain}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo.stg:id/cl_more
        Exit For Loop If    ${more_contain}
        Sleep    1
    END    
    Element Text Should Be    com.skt.nugu.apollo.stg:id/tv_speed    속도 (2.0x)    #2.0배속인지 확인
    Click Element    com.skt.nugu.apollo.stg:id/tv_speed
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_title    #배속 설정 진입 확인
    Click Element    com.skt.nugu.apollo.stg:id/tv_10    #1.0배속으로 변경
    Click Element    class=android.view.View    #팝업 바깥 영역 선택하여 닫기

    FOR  ${i}  IN RANGE    0    5
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${more_contain}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo.stg:id/cl_more
        Exit For Loop If    ${more_contain}
        Sleep    1
    END    
    Element Text Should Be    com.skt.nugu.apollo.stg:id/tv_speed    속도 (1.0x)    #1.0배속인지 확인

플레이어 컴포넌트 > 화면 잠금
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 컴포넌트 호출하여 lock 버튼 클릭    /    3. 컴포넌트 노출되지 않는지 확인
    #4. 컴포넌트 호출하여 unlock 버튼 클릭    /    4. 컴포넌트 노출되면 pass

    [Tags]    Player
    full 화면 진입
    FOR  ${i}  IN RANGE    0    5    #컴포넌트 호출하여 lock 버튼 클릭
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View 
        ${pass}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo.stg:id/cl_lock
        Exit For Loop If    ${pass}
        Sleep    1
    END
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
    Wait Until Page Does Not Contain Element    com.skt.nugu.apollo.stg:id/iv_play_pause    #컴포넌트 미 노출 확인

    FOR  ${i}  IN RANGE    0    5    #컴포넌트 호출하여 unlock 버튼 클릭
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${pass}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo.stg:id/lock_click_view
        Exit For Loop If    ${pass}
        Sleep    1
    END
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/iv_play_pause    #컴포넌트 노출 확인

플레이어 컴포넌트 > 다운로드 관리 보기
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 컴포넌트 호출하여 다운로드 관리 진입    /    3. 다운로드 관리 타이틀 노출 시 pass 

    [Tags]    Player
    full 화면 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View    #화면 탭하여 컴포넌트 호출
    Sleep    1
    Click Element    com.skt.nugu.apollo.stg:id/iv_setting    #다운로드 관리 버튼 선택
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/textView    #다운로드 관리 타이틀

플레이어 > 팝업 플레이어(PIP) 전환 > 에이닷 재진입
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 하드웨어 홈키 입력    /    2. pip 전환
    #3. 앱 재진입    /    3. player 재생 화면 전환 확인될 경우 pass (상세 정보 버튼 노출 여부로 인식)

    [Tags]    Player
    Click Element    Xpath=//android.widget.TextView[@text="TV"]
    Sleep    5
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/cl_content_area
    Sleep    2
    Press Keycode    3    #하드웨어 홈키
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Activate Application    ${appPackage}
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_detail_info_btn

플레이어 > 다운로드 관리에서 My TV 이탈
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 컴포넌트 호출하여 다운로드 관리 진입
    #4. 하드웨어 홈키 입력 > 앱 재진입    /    4. 다운로드 관리 타이틀 노출 확인

    [Tags]    Player
    full 화면 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View    #화면 탭하여 컴포넌트 호출
    Sleep    1
    Click Element    com.skt.nugu.apollo.stg:id/iv_setting    #다운로드 관리 버튼 선택
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/textView    #다운로드 관리 타이틀
    Press Keycode    3    #하드웨어 홈키
    Sleep    2
    Wait Until Keyword Succeeds    1 min    3 sec    Activate Application    ${appPackage}
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/textView    #다운로드 관리 타이틀

플레이어 > PIP 재생 중 Full player 전환
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입    /    2. pip 전환 전 runtime 값 저장
    #3. 하드웨어 홈키 > 5초 후 앱 재진입    /    4. pip 재생 중 full player 복귀 시, 영상 이어서 재생되면 pass

    [Tags]    Player
    full 화면 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
    Sleep    1
    ${runtime}=    Get Text    com.skt.nugu.apollo.stg:id/tv_end_time
    Sleep    1

    Press Keycode    3    #하드웨어 홈키
    Sleep    5
    Wait Until Keyword Succeeds    1 min    3 sec    Activate Application    ${appPackage}    #앱 재실행
    Sleep    1
    
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
    Sleep    1
    ${current_runtime}=    Get Text    com.skt.nugu.apollo.stg:id/tv_runtime
    Should Not Be Equal    ${runtime}    ${current_runtime}

플레이어 > 컴포넌트 미노출 상태
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 컴포넌트 호출 후 5초 대기    /    3. 컴포넌트 미 노출 확인
    #4. 컴포넌트 호출 후 화면 탭    /    4. 컴포넌트 미 노출 확인 시 pass

    [Tags]    Player
    full 화면 진입
    FOR  ${i}  IN RANGE    0    5    #컴포넌트 정상 노출될때까지 화면 탭 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${pass}=    Run Keyword And Return Status    Wait Until Page Contains Element    com.skt.nugu.apollo.stg:id/iv_play_pause
        Exit For Loop If    ${pass}
        Sleep    1
    END  
    Sleep    5
    Page Should Not Contain Element    com.skt.nugu.apollo.stg:id/iv_play_pause

    FOR  ${i}  IN RANGE    0    5    #컴포넌트 정상 노출될때까지 화면 탭 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${pass}=    Run Keyword And Return Status    Wait Until Page Contains Element    com.skt.nugu.apollo.stg:id/iv_play_pause
        Exit For Loop If    ${pass}
        Sleep    1
    END
    Click Element    com.skt.nugu.apollo.stg:id/tabBorder    #화면 탭
    Sleep    2
    Page Should Not Contain Element    com.skt.nugu.apollo.stg:id/iv_play_pause

플레이어 > 컴포넌트 미노출 상태에서 채널 전환
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 컴포넌트 미노출 상태에서 하단 스와이프
    #4. 컴포넌트 미노출 상태에서 상단 스와이프    /    5. 추천정보 내 채널명 변경 시 pass

    [Tags]    Player
    full 화면 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    50    90    50    10    #하단 스와이프
    Sleep    1
    ${down_swipe}    Get Text    com.skt.nugu.apollo.stg:id/tv_channel_name
    Sleep    5
    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    50    10    50    90    #상단 스와이프
    Sleep    1
    ${up_swipe}    Get Text    com.skt.nugu.apollo.stg:id/tv_channel_name
    Should Not Be Equal    ${down_swipe}    ${up_swipe}    #하단/상단 스와이프 시, 채널명 변경 확인

플레이어 > 컴포넌트 미노출 상태에서 콘텐츠 전환
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 컴포넌트 미노출 상태에서 우측 스와이프
    #4. 컴포넌트 미노출 상태에서 좌측 스와이프    /    5. 추천정보 내 프로그램명 변경 시 pass

    [Tags]    Player
    full 화면 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    70    50    30    50    #우측 스와이프
    Sleep    1
    ${right_swipe}    Get Text    Xpath=//android.widget.TextView[@resource-id="com.skt.nugu.apollo.stg:id/tv_title"]
    Sleep    5
    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    30    50    70    50    #좌측 스와이프
    Sleep    1
    ${left_swipe}    Get Text    Xpath=//android.widget.TextView[@resource-id="com.skt.nugu.apollo.stg:id/tv_title"]
    Should Not Be Equal    ${right_swipe}    ${left_swipe}    #좌/우 스와이프 시, 프로그램명 변경 확인

다운로드 관리
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 우상단 다운로드 관리 버튼 선택
    #2. 자동 다운로드 토글 버튼 선택    /    4. on/off 변경 확인 시 pass

    [Tags]    시놉시스
    Click Element    Xpath=//android.widget.TextView[@text="TV"]
    Sleep    8
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/storageManager
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/storageManager    #다운로드 관리 진입 
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/textView24    #자동 다운로드 사용 타이틀

    ${1st_checked}=    Get Element Attribute    com.skt.nugu.apollo.stg:id/switch_Download    checked
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/switch_Download    #토글 선택
    ${2nd_checked}=    Get Element Attribute    com.skt.nugu.apollo.stg:id/switch_Download    checked
    Should Not Be Equal    ${1st_checked}    ${2nd_checked}    #토글 선택 전과 후 값 비교하여 변경 확인

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/switch_Download    #토글 선택

다운로드 닫기 버튼
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 우상단 다운로드 관리 버튼 선택
    #2. 우상단 닫기 버튼    /    4. 다운로드 관리 화면 보이지 않으면 pass

    [Tags]    시놉시스
    Click Element    Xpath=//android.widget.TextView[@text="TV"]
    Sleep    8
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/storageManager
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/storageManager    #다운로드 관리 진입
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/textView    #다운로드 관리 진입 확인
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/imageView2    #닫기 버튼 선택
    Sleep    1
    Page Should Not Contain Element    com.skt.nugu.apollo.stg:id/textView    #다운로드 관리 타이틀 미노출 시 pass

추천 정보 노출 상태에서 채널 전환
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 하단 스와이프 세번 반복
    #4. 상단 스와이프 세번 반복 

    [Tags]    Player
    full 화면 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    50    90    50    10    #하단 스와이프
    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    50    90    50    10    #하단 스와이프
    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    50    90    50    10    #하단 스와이프

    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    50    10    50    90    #상단 스와이프
    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    50    10    50    90    #상단 스와이프
    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    50    10    50    90    #상단 스와이프

추천 정보, 컴포넌트 노출 상태에서 콘텐츠 전환
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 우측 스와이프 세번 반복
    #4. 좌측 스와이프 세번 반복

    [Tags]    Player
    full 화면 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    70    50    30    50    #우측 스와이프
    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    70    50    30    50    #우측 스와이프
    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    70    50    30    50    #우측 스와이프

    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    30    50    70    50    #좌측 스와이프
    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    30    50    70    50    #좌측 스와이프
    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    30    50    70    50    #좌측 스와이프

화면 내 팝업이 노출되는 상황에서 콘텐츠 전환
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 컴포넌트 호출하여 상세정보 진입
    #4. 우측 스와이프    /    4. 채널전환 시에만 노출되는 캐릭터 이미지 미 노출 확인
    #5. 좌측 스와이프    /    4. 채널전환 시에만 노출되는 캐릭터 이미지 미 노출 시 pass

    [Tags]    Player
    full 화면 진입
    FOR  ${i}  IN RANGE    0    5    #상세정보 버튼 인식 시점까지 컴포넌트 호출 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${info_contain}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo.stg:id/iv_info
        Exit For Loop If    ${info_contain}
        Sleep    1
    END
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_view

    Swipe By Percent    70    50    30    50    #우측 스와이프
    Page Should Not Contain Element    com.skt.nugu.apollo.stg:id/iv_character    #채널전환 시에만 노출되는 캐릭터 이미지 미 노출 확인
    Wait Until Keyword Succeeds    1 min    3 sec    Swipe By Percent    30    50    70    50    #좌측 스와이프
    Page Should Not Contain Element    com.skt.nugu.apollo.stg:id/iv_character    #채널전환 시에만 노출되는 캐릭터 이미지 미 노출 확인

컴포넌트 구성 개선 - 하단
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 컴포넌트 호출하여 하단 영역 확인    /    3. 프로그레스바, 좋아요, 별로예요, 화면잠금, 더보기 노출 확인시 pass

    [Tags]    Player
    full 화면 진입
    FOR  ${i}  IN RANGE    0    5    #프로그레스 바 인식 시점까지 컴포넌트 호출 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${progress}=    Run Keyword And Return Status    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/bottom_seekbar
        Exit For Loop If    ${progress}
        Sleep    1
    END

    FOR  ${i}  IN RANGE    0    5    #좋아요 버튼 인식 시점까지 컴포넌트 호출 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${like}=    Run Keyword And Return Status    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/iv_like
        Exit For Loop If    ${like}
        Sleep    1
    END

    FOR  ${i}  IN RANGE    0    5    #싫어요 버튼 인식 시점까지 컴포넌트 호출 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${disLike}=    Run Keyword And Return Status    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/iv_disLike
        Exit For Loop If    ${disLike}
        Sleep    1
    END

    FOR  ${i}  IN RANGE    0    5    #잠금 버튼 인식 시점까지 컴포넌트 호출 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${lock}=    Run Keyword And Return Status    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/cl_lock
        Exit For Loop If    ${lock}
        Sleep    1
    END

    FOR  ${i}  IN RANGE    0    5    #더보기 버튼 인식 시점까지 컴포넌트 호출 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${more}=    Run Keyword And Return Status    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/cl_more
        Exit For Loop If    ${more}
        Sleep    1
    END

컴포넌트 구성 개선 - 재생 영역
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 컴포넌트 호출하여 재생 영역 확인    /    3. 밝기 조절, 볼륨 조절, 되감기, 빨리감기, 재생/일시정지 노출 확인시 pass

    [Tags]    Player
    full 화면 진입
    FOR  ${i}  IN RANGE    0    5    #밝기조절 바 인식 시점까지 컴포넌트 호출 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${brightness}=    Run Keyword And Return Status    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/brightness_bar
        Exit For Loop If    ${brightness}
        Sleep    1
    END

    FOR  ${i}  IN RANGE    0    5    #볼륨조절 바 인식 시점까지 컴포넌트 호출 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${sound}=    Run Keyword And Return Status    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/sound_bar
        Exit For Loop If    ${sound}
        Sleep    1
    END

    FOR  ${i}  IN RANGE    0    5    #되감기 버튼 인식 시점까지 컴포넌트 호출 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${rewind}=    Run Keyword And Return Status    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_rewind
        Exit For Loop If    ${rewind}
        Sleep    1
    END

    FOR  ${i}  IN RANGE    0    5    #빨리감기 버튼 인식 시점까지 컴포넌트 호출 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${forward}=    Run Keyword And Return Status    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_forward
        Exit For Loop If    ${forward}
        Sleep    1
    END

    FOR  ${i}  IN RANGE    0    5    #재생/일시정지 버튼 인식 시점까지 컴포넌트 호출 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${play_pause}=    Run Keyword And Return Status    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/iv_play_pause
        Exit For Loop If    ${play_pause}
        Sleep    1
    END

컴포넌트 구성 개선 - 상단
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 컴포넌트 호출하여 상단 영역 확인    /    3. 채널명, 콘텐츠명, 상세정보, 나가기, 편성표, 다운로드 관리 버튼 노출 확인시 pass

    [Tags]    Player
    full 화면 진입
    FOR  ${i}  IN RANGE    0    5    #채널명 인식 시점까지 컴포넌트 호출 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${channel}=    Run Keyword And Return Status    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_channel_name
        Exit For Loop If    ${channel}
        Sleep    1
    END

    FOR  ${i}  IN RANGE    0    5    #콘텐츠명 인식 시점까지 컴포넌트 호출 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${title}=    Run Keyword And Return Status    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/tv_title
        Exit For Loop If    ${title}
        Sleep    1
    END

    FOR  ${i}  IN RANGE    0    5    #상세정보 버튼 인식 시점까지 컴포넌트 호출 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${info}=    Run Keyword And Return Status    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/iv_info
        Exit For Loop If    ${info}
        Sleep    1
    END

    FOR  ${i}  IN RANGE    0    5    #나가기 버튼 인식 시점까지 컴포넌트 호출 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${mini}=    Run Keyword And Return Status    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/iv_mini_play
        Exit For Loop If    ${mini}
        Sleep    1
    END

    FOR  ${i}  IN RANGE    0    5    #편성표 버튼 인식 시점까지 컴포넌트 호출 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${schedule}=    Run Keyword And Return Status    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/iv_schedule
        Exit For Loop If    ${schedule}
        Sleep    1
    END

    FOR  ${i}  IN RANGE    0    5    #다운로드 관리 버튼 인식 시점까지 컴포넌트 호출 반복
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
        ${storageManager}=    Run Keyword And Return Status    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/storageManager
        Exit For Loop If    ${storageManager}
        Sleep    1
    END

다운로드 관리 화면 구성 및 제공 문구 개선
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 우상단 다운로드 관리 버튼 선택
    #2. 다운로드 관리 화면 구성 확인    /    2. 다운로드 공간 설정, 자동 다운로드 사용, 다운로드 콘텐츠 영역 확인
    #3. '자동 다운로드 안내' 버튼 선택    /    3. 툴팁 문구 노출 확인

    [Tags]    시놉시스
    Click Element    Xpath=//android.widget.TextView[@text="TV"]
    Sleep    8
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/storageManager
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/storageManager    #다운로드 관리 진입
    Sleep    1

    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/cl_download_on_layout    #<다운로드 공간 설정> 영역
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/downloadUseContainer    #<자동 다운로드 사용> 영역
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/cl_bottom_area    #<다운로드 콘텐츠> 영역

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/autoDownloadGuide    #자동 다운로드 안내 버튼 선택
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="기기를 충전 중이며 A.(에이닷) 앱의 배터리\n사용량 설정이 ‘제한 없음'으로 되어 있는 경우,\n추천 콘텐츠가 자동 다운로드돼요."]
    Sleep    5

편성표 - 도움말
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 최상단 영상 진입
    #2. 화면 탭 > full player 진입
    #3. 화면 탭하여 컴포넌트 호출 > 우상단 편성표 버튼 선택    /    3. 편성 정보 타이틀 노출 확인
    #4. 채널 안내 버튼 선택    /    4. 채널 안내 문구 일치 확인
    #5. 확인 버튼 선택    /    5. 채널 안내 팝업 종료 확인 시 pass

    [Tags]    Player
    full 화면 진입
    Click Element    class=android.view.View
    Click Element    com.skt.nugu.apollo.stg:id/iv_schedule
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/labelScheduleInfo    #편성표 진입 확인
    
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.ImageButton[@clickable="true" and @index="1"]    #채널 안내 버튼 선택
    Sleep    2

    Wait Until Keyword Succeeds    1 min    3 sec    Element Text Should Be    com.skt.nugu.apollo.stg:id/title    채널 안내    
    Wait Until Keyword Succeeds    1 min    3 sec    Element Text Should Be    com.skt.nugu.apollo.stg:id/subTitle    A.tv는 VOD를 특정 테마로 묶어 채널을 편성해요.\n플래그가 있는 채널은 조금 다른 기준으로 제공되는\n채널이에요.
    Page Should Contain Element    Xpath=//hierarchy/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.ScrollView/androidx.appcompat.widget.LinearLayoutCompat/androidx.appcompat.widget.LinearLayoutCompat[1]/android.widget.ImageView    #LIVE 플래그 노출 확인
    Page Should Contain Element    Xpath=//hierarchy/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.ScrollView/androidx.appcompat.widget.LinearLayoutCompat/androidx.appcompat.widget.LinearLayoutCompat[2]/android.widget.ImageView    #ON AIR 플래그 노출 확인
    Page Should Contain Element    Xpath=//hierarchy/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.widget.ScrollView/androidx.appcompat.widget.LinearLayoutCompat/androidx.appcompat.widget.LinearLayoutCompat[3]/android.widget.ImageView    #몰아보기 플래그 노출 확인

    Page Should Contain Element    Xpath=//android.widget.TextView[@text="생방송 채널"]
    Page Should Contain Element    Xpath=//android.widget.TextView[@text="VOD 스트리밍 채널"]
    Page Should Contain Element    Xpath=//android.widget.TextView[@text="하나의 시리즈로 만들어진 채널"]
    Page Should Contain Element    Xpath=//android.widget.TextView[@text="*LIVE와 ON AIR 채널은 재생 속도 변경, 건너뛰기 등의 기능을 이용할 수 없어요."]
    
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/confirmButton    #확인 버튼 선택
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/refreshButton    #새로고침 버튼
    Page Should Not Contain Element    com.skt.nugu.apollo.stg:id/title

다운로드 관리 - 다운로드 콘텐츠
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 우상단 다운로드 관리 버튼 선택
    #2. 다운로드 관리 화면 구성 확인 > 하단 "다운로드한 콘텐츠가 없어요." 문구 노출 확인
    #3. 전체 삭제 버튼 누를시 "다운로드 콘텐츠를 전부 삭제하시겠어요?" 팝업 노출로 Dimmed 처리 확인
    
    [Tags]    Player
    Click Element    Xpath=//android.widget.TextView[@text="TV"]
    Sleep    8
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/storageManager
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/storageManager    #다운로드 관리 진입
    Sleep    5
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/cl_bottom_area    #<다운로드 콘텐츠> 영역
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Element Text Should Be    com.skt.nugu.apollo.stg:id/tv_blank_noti    다운로드한 콘텐츠가 없어요.
    Sleep    1

    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/tv_delete_all    #전체삭제 버튼
    Page Should Not Contain Element    Xpath=//android.widget.TextView[@text="다운로드 콘텐츠를\n전부 삭제하시겠어요?"]    #전체삭제 안내 팝업 노출되지 않는지 확인

다운로드 관리 - 영역 순서
    #1. 에이닷 실행 > "앱" > "TV" 선택 > 우상단 다운로드 관리 버튼 선택
    #2. 다운로드 관리 화면 영역 순서 확인    /    2. 다운로드 공간 설정, 자동 다운로드 사용, 다운로드 콘텐츠 영역 순서대로 노출 시 pass
    
    [Tags]    Player
    Click Element    Xpath=//android.widget.TextView[@text="TV"]
    Sleep    8
    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/storageManager
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/storageManager    #다운로드 관리 진입
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Element Should Be Visible    Xpath=//android.view.ViewGroup[@resource-id="com.skt.nugu.apollo.stg:id/cl_download_on_layout" and @index="0"]    #다운로드 공간 설정 영역
    Wait Until Keyword Succeeds    1 min    3 sec    Element Should Be Visible    Xpath=//android.view.ViewGroup[@resource-id="com.skt.nugu.apollo.stg:id/downloadUseContainer" and @index="1"]    #자동 다운로드 사용 영역
    Wait Until Keyword Succeeds    1 min    3 sec    Element Should Be Visible    Xpath=//android.view.ViewGroup[@resource-id="com.skt.nugu.apollo.stg:id/cl_bottom_area" and @index="4"]    #다운로드 콘텐츠 영역

프로농구 홈 - 응원팀 미설정
    #1. 에이닷 실행 > "앱" > "프로농구" 선택
    #2. 응원팀 영역 노출 확인

    [Tags]    Player
    FOR  ${i}  IN RANGE    0    5    #프로농구까지 스와이프
        Swipe By Percent    50    90    50    10
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text="프로농구"]
        Exit For Loop If    ${pass}
    END
    Sleep    1
    Click Element    Xpath=//android.widget.TextView[@text="프로농구"]
    Sleep    8
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    com.skt.nugu.apollo.stg:id/cl_my_team_empty_area
    Sleep    1

프로농구 홈 - 응원팀 설정 팝업
    #0. 응원팀 미설정 상태
    #1. 에이닷 실행 > "앱" > "프로농구" 선택
    #2. 응원팀 설정 > 응원팀 선택시, 적용 버튼 활성화

    [Tags]    Player
    FOR  ${i}  IN RANGE    0    5    #프로농구까지 스와이프
        Swipe By Percent    50    90    50    10
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text="프로농구"]
        Exit For Loop If    ${pass}
    END
    Sleep    1
    Click Element    Xpath=//android.widget.TextView[@text="프로농구"]
    Sleep    8
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/textView6
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@resource-id="com.skt.nugu.apollo.stg:id/tv_team_name" and @text="대구 한국가스공사"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/tv_ok
    Sleep    1
    Page Should Not Contain Element    Xpath=//android.view.ViewGroup[@resource-id="com.skt.nugu.apollo.stg:id/cl_root"]

프로농구 홈 - 응원팀 정보
    #0. 응원팀 설정 상태
    #1. 에이닷 실행 > "앱" > "프로농구" 선택
    #2. 프로농구 홈 > 상단 내 응원팀 영역 확인
    #3. 로고 + 팀 명 선택 시 <팀 정보> 화면으로 이동 / 팀 변경 버튼 선택 시 <응원팀 설정> 팝업 제공 확인

    [Tags]    Player
    FOR  ${i}  IN RANGE    0    5    #프로농구까지 스와이프
        Swipe By Percent    50    90    50    10
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text="프로농구"]
        Exit For Loop If    ${pass}
    END
    Sleep    1
    Click Element    Xpath=//android.widget.TextView[@text="프로농구"]
    Sleep    8
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/iv_my_team_logo
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Element Should Be Visible    com.skt.nugu.apollo.stg:id/tv_title
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/buttonExit
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/cl_change_my_team
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Element Should Be Visible    Xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]

프로농구 홈 - 응원팀 변경
    #0. 응원팀 설정 상태
    #1. 에이닷 실행 > "앱" > "프로농구" 선택
    #2. 프로농구 홈 > 상단 내 응원팀 영역 확인
    #3. 응원팀 변경 버튼 선택 > 응원팀 변경 확인

    [Tags]    Player
    FOR  ${i}  IN RANGE    0    5    #프로농구까지 스와이프
        Swipe By Percent    50    90    50    10
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text="프로농구"]
        Exit For Loop If    ${pass}
    END
    Sleep    1
    Click Element    Xpath=//android.widget.TextView[@text="프로농구"]
    Sleep    8
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/cl_change_my_team
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@resource-id="com.skt.nugu.apollo.stg:id/tv_team_name" and @text="서울 SK"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/tv_ok
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/cl_change_my_team
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@resource-id="com.skt.nugu.apollo.stg:id/tv_team_name" and @text="서울 SK"]
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/tv_ok



