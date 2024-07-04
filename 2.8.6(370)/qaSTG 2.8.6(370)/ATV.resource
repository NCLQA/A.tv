*** Settings ***
Library  AppiumLibrary

*** Variables ***
${deviceName}    R5CR8050X6P    #테스트대상 단말입력
${appPackage}    com.skt.nugu.apollo.stg 
${appActivity}    com.skt.nugu.visual.home.HomeActivity

*** Keywords ***
에이닷 실행
    Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=${deviceName}    appPackage=${appPackage}    appActivity=${appActivity}    automationName=UIAutomator2    noReset=true

에이닷 종료 후 재진입
    Wait Until Keyword Succeeds    1 min    3 sec    Terminate Application    ${appPackage}
    Sleep    3
    Wait Until Keyword Succeeds    1 min    3 sec    Activate Application    ${appPackage}
    Sleep    6
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="앱"] 

미디어 메뉴 진입
    FOR  ${i}  IN RANGE    0    5    #TV 메뉴까지 스와이프
        Swipe By Percent    50    90    50    10
        ${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@text="미디어"]
        Exit For Loop If    ${pass}
    END   
    Sleep    1
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="미디어"]

full 화면 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/player_view
    Sleep    1
    FOR  ${i}  IN RANGE    0    10
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo.stg:id/tabBorder
        ${pass}=    Run Keyword And Return Status    Click Element    Xpath=//android.view.ViewGroup[@resource-id="com.skt.nugu.apollo.stg:id/bottom_container"]/android.view.ViewGroup    #전체화면
        Exit For Loop If    ${pass}
        Sleep    1
        Click Element    com.skt.nugu.apollo.stg:id/iv_play_pause
    END
    Sleep    2

#최근 시청 카드 선택
    #FOR  ${i}  IN RANGE    0    5    #최근 시청 카드플레이까지 스와이프
        #Swipe By Percent    30    60    20    10
        #${pass}    Run Keyword And Return Status    Wait until Element Is Visible    Xpath=//android.widget.TextView[@resource-id="com.skt.nugu.apollo.stg:id/tv_channel_title" and @text="최근 시청 (추천)"]
        #Exit For Loop If    ${pass}
    #END
    #Sleep    5

골프 메뉴 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="골프"]