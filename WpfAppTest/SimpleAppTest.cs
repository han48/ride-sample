using OpenQA.Selenium;
using OpenQA.Selenium.Appium;
using OpenQA.Selenium.Appium.Windows;
using OpenQA.Selenium.Remote;
using System;
using System.Reflection;

namespace WpfAppTest;

[TestClass]
public sealed class SimpleAppTest
{
    private const string WindowsApplicationDriverUrl = "http://127.0.0.1:4723";
    private string? currentPath;
    private const string AppPath = @"..\..\..\..\SimpleApp\bin\Debug\net9.0-windows\SimpleApp.exe";
    private WindowsDriver? _session;

    [TestInitialize]
    public void Setup()
    {
        currentPath = System.IO.Path.GetDirectoryName(Assembly.GetEntryAssembly().Location);
        AppiumOptions appiumOptions = new AppiumOptions();
        appiumOptions.PlatformName = "Windows";
        appiumOptions.DeviceName = "WindowsPC";
        appiumOptions.App = Path.Combine(currentPath, AppPath);
        Console.WriteLine(appiumOptions.App);
        _session = new WindowsDriver(new Uri(WindowsApplicationDriverUrl), appiumOptions);
    }

    [TestCleanup]
    public void TearDown()
    {
        _session?.Quit();
    }

    [TestMethod]
    public void SaveFile()
    {
        if (_session == null)
        {
            Assert.Fail("Can not start application");
        }
        AppiumElement textBox = _session.FindElement(By.Name("txtBox"));
        textBox.SendKeys("Hello, this is a test.");

        AppiumElement fileMenu = _session.FindElement(By.Name("mnFile"));
        fileMenu.Click();

        var saveAsMenuItem = _session.FindElement(By.Name("mnSaveAs"));
        saveAsMenuItem.Click();

        var saveFileDialog = _session.FindElement(By.ClassName("#32770")); // Class name for common dialog GET with AutoIt
        var fileNameBox = saveFileDialog.FindElement(By.ClassName("Edit"));
        fileNameBox.SendKeys(Path.Combine(currentPath, "test.txt"));

        var saveButton = saveFileDialog.FindElement(By.Name("Save"));
        saveButton.Click();
    }
}
