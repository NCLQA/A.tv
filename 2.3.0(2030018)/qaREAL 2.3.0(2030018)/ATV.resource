*** Settings ***
Library  AppiumLibrary

*** Variables ***
${deviceName}    R5CR8050X6P    #테스트대상 단말입력
${appPackage}    com.skt.nugu.apollo   
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
    Wait Until Keyword Succeeds    1 min    3 sec    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="TV"]
    Sleep    1

full 화면 진입
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    Xpath=//android.widget.TextView[@text="TV"]
    Sleep    5
    Wait Until Keyword Succeeds    1 min    3 sec    Click Element    class=android.view.View
    Sleep    1
    FOR  ${i}  IN RANGE    0    10
        Wait Until Keyword Succeeds    1 min    3 sec    Click Element    com.skt.nugu.apollo:id/tabBorder
        ${pass}=    Run Keyword And Return Status    Click Element    com.skt.nugu.apollo:id/iv_full
        Exit For Loop If    ${pass}
        Sleep    1
    END   
    Sleep    2