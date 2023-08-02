*** Settings ***
Library  AppiumLibrary

*** Variables ***
${deviceName}    R5CR8050X6P
${appPackage}    com.skt.nugu.apollo
${appActivity}    com.skt.nugu.visual.home.HomeActivity

*** Keywords ***
에이닷 실행
    Open Application    http://localhost:4723/wd/hub    platformName=Android    deviceName=${deviceName}    appPackage=${appPackage}    appActivity=${appActivity}    automationName=UIAutomator2    noReset=true

에이닷 종료 후 재진입
    Terminate Application    ${appPackage}
    Sleep    3
    Activate Application    ${appPackage}
    Sleep    5
    Click Element    Xpath=//android.widget.TextView[@text="메뉴"]
    Sleep    1
    Wait Until Element Is Visible    Xpath=//android.widget.TextView[@text="TV"]
    Sleep    1