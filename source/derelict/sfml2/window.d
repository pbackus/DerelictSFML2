/*

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license ( the "Software" ) to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

*/
module derelict.sfml2.window;

private {
    import derelict.util.loader;
    import derelict.util.system;
    import derelict.sfml2.system;

    static if( Derelict_OS_Windows )
        enum libNames = "csfml-window-2.2.dll,csfml-window-2.dll";
    else static if( Derelict_OS_Mac )
        enum libNames = "libcsfml-window.2.2.dylib,libcsfml-window.2.dylib";
    else static if( Derelict_OS_Posix )
        enum libNames = "libcsfml-window.so.2.2,libcsfml-window.so.2";
    else
        static assert( 0, "Need to implement SFML2 Window libNames for this operating system." );
}

// Window/Types.h
struct sfContext;
struct sfWindow;

// Window/Event.h
alias sfEventType = int;
enum {
    sfEvtClosed,
    sfEvtResized,
    sfEvtLostFocus,
    sfEvtGainedFocus,
    sfEvtTextEntered,
    sfEvtKeyPressed,
    sfEvtKeyReleased,
    sfEvtMouseWheelMoved,
    sfEvtMouseButtonPressed,
    sfEvtMouseButtonReleased,
    sfEvtMouseMoved,
    sfEvtMouseEntered,
    sfEvtMouseLeft,
    sfEvtJoystickButtonPressed,
    sfEvtJoystickButtonReleased,
    sfEvtJoystickMoved,
    sfEvtJoystickConnected,
    sfEvtJoystickDisconnected,
    sfEvtTouchBegan,
    sfEvtTouchMoved,
    sfEvtTouchEnded,
    sfEvtSensorChanged,

    sfEvtCount
}

struct sfKeyEvent {
    sfEventType type;
    sfKeyCode   code;
    sfBool      alt;
    sfBool      control;
    sfBool      shift;
    sfBool      system;
}

struct sfTextEvent {
    sfEventType type;
    sfUint32    unicode;
}

struct sfMouseMoveEvent {
    sfEventType type;
    int         x;
    int         y;
}

struct sfMouseButtonEvent {
    sfEventType   type;
    sfMouseButton button;
    int           x;
    int           y;
}

struct sfMouseWheelEvent {
    sfEventType type;
    int         delta;
    int         x;
    int         y;
}

struct sfJoystickMoveEvent {
    sfEventType    type;
    uint   joystickId;
    sfJoystickAxis axis;
    float          position;
}

struct sfJoystickButtonEvent {
    sfEventType  type;
    uint joystickId;
    uint button;
}

struct sfJoystickConnectEvent {
    sfEventType  type;
    uint joystickId;
}

struct sfSizeEvent {
    sfEventType  type;
    uint width;
    uint height;
}

struct sfTouchEvent {
    sfEventType type;
    uint finger;
    int x;
    int y;
}

struct sfSensorEvent {
    sfEventType type;
    sfSensorType sensorType;
    float x;
    float y;
    float z;
}

union sfEvent {
    sfEventType type;
    sfSizeEvent size;
    sfKeyEvent key;
    sfTextEvent text;
    sfMouseMoveEvent mouseMove;
    sfMouseButtonEvent mouseButton;
    sfMouseWheelEvent mouseWheel;
    sfJoystickMoveEvent joystickMove;
    sfJoystickButtonEvent joystickButton;
    sfJoystickConnectEvent joystickConnect;
    sfTouchEvent touch;
    sfSensorEvent sensor;
}

alias sfJoystickAxis = int;
enum {
    sfJoystickX,
    sfJoystickY,
    sfJoystickZ,
    sfJoystickR,
    sfJoystickU,
    sfJoystickV,
    sfJoystickPovX,
    sfJoystickPovY
}

// Window/Joystick.h
enum {
    sfJoystickCount = 8,
    sfJoystickButtonCount = 32,
    sfJoystickAxisCount = 8,
}

// Window/JoystickIdentification.h
struct sfJoystickIdentification {
    const( char )* name;
    uint vendorId;
    uint productId;
}

// Window/Keyboard.h
alias sfKeyCode = int;
enum {
    sfKeyA,
    sfKeyB,
    sfKeyC,
    sfKeyD,
    sfKeyE,
    sfKeyF,
    sfKeyG,
    sfKeyH,
    sfKeyI,
    sfKeyJ,
    sfKeyK,
    sfKeyL,
    sfKeyM,
    sfKeyN,
    sfKeyO,
    sfKeyP,
    sfKeyQ,
    sfKeyR,
    sfKeyS,
    sfKeyT,
    sfKeyU,
    sfKeyV,
    sfKeyW,
    sfKeyX,
    sfKeyY,
    sfKeyZ,
    sfKeyNum0,
    sfKeyNum1,
    sfKeyNum2,
    sfKeyNum3,
    sfKeyNum4,
    sfKeyNum5,
    sfKeyNum6,
    sfKeyNum7,
    sfKeyNum8,
    sfKeyNum9,
    sfKeyEscape,
    sfKeyLControl,
    sfKeyLShift,
    sfKeyLAlt,
    sfKeyLSystem,
    sfKeyRControl,
    sfKeyRShift,
    sfKeyRAlt,
    sfKeyRSystem,
    sfKeyMenu,
    sfKeyLBracket,
    sfKeyRBracket,
    sfKeySemiColon,
    sfKeyComma,
    sfKeyPeriod,
    sfKeyQuote,
    sfKeySlash,
    sfKeyBackSlash,
    sfKeyTilde,
    sfKeyEqual,
    sfKeyDash,
    sfKeySpace,
    sfKeyReturn,
    sfKeyBack,
    sfKeyTab,
    sfKeyPageUp,
    sfKeyPageDown,
    sfKeyEnd,
    sfKeyHome,
    sfKeyInsert,
    sfKeyDelete,
    sfKeyAdd,
    sfKeySubtract,
    sfKeyMultiply,
    sfKeyDivide,
    sfKeyLeft,
    sfKeyRight,
    sfKeyUp,
    sfKeyDown,
    sfKeyNumpad0,
    sfKeyNumpad1,
    sfKeyNumpad2,
    sfKeyNumpad3,
    sfKeyNumpad4,
    sfKeyNumpad5,
    sfKeyNumpad6,
    sfKeyNumpad7,
    sfKeyNumpad8,
    sfKeyNumpad9,
    sfKeyF1,
    sfKeyF2,
    sfKeyF3,
    sfKeyF4,
    sfKeyF5,
    sfKeyF6,
    sfKeyF7,
    sfKeyF8,
    sfKeyF9,
    sfKeyF10,
    sfKeyF11,
    sfKeyF12,
    sfKeyF13,
    sfKeyF14,
    sfKeyF15,
    sfKeyPause,
    sfKeyCount
}

// Window/Mouse.h
alias sfMouseButton = int;
enum {
    sfMouseLeft,
    sfMouseRight,
    sfMouseMiddle,
    sfMouseXButton1,
    sfMouseXButton2,
    sfMouseButtonCount,
}

// Window/Sensor.h
alias sfSensorType = int;
enum {
    sfSensorAccelerometer,
    sfSensorGyroscope,
    sfSensorMagnetometer,
    sfSensorGravity,
    sfSensorUserAcceleration,
    sfSensorOrientation,

    sfSensorCount
}

// Window/VideoMode.h
struct sfVideoMode {
    uint width;
    uint height;
    uint bitsPerPixel;
}

// Window/Window.h
alias sfWindowStyle = uint;
enum : uint {
    sfNone = 0,
    sfTitlebar = 1 << 0,
    sfResize = 1 << 1,
    sfClose = 1 << 2,
    sfFullscreen = 1 << 3,
    sfDefaultStyle = sfTitlebar | sfResize | sfClose,
}

struct sfContextSettings {
    uint depthBits;
    uint stencilBits;
    uint antialiasingLevel;
    uint majorVersion;
    uint minorVersion;
}

// Window/WindowHandle.h
private import derelict.util.system;

static if( Derelict_OS_Windows || Derelict_OS_Mac ) {
    alias void* sfWindowHandle;
} else static if( Derelict_OS_Posix ) {
    private import core.stdc.config;
    alias c_ulong sfWindowHandle;
}

extern( C ) @nogc nothrow {
    // Window/Contex.h
    alias da_sfContext_create = sfContext* function();
    alias da_sfContext_destroy = void function( sfContext* );
    alias da_sfContext_setActive = void function( sfContext*,sfBool );

    // Window/Joystick.h
    alias da_sfJoystick_isConnected = sfBool function( uint );
    alias da_sfJoystick_getButtonCount = uint function( uint );
    alias da_sfJoystick_hasAxis = sfBool function( uint, sfJoystickAxis );
    alias da_sfJoystick_isButtonPressed = sfBool function( uint, uint );
    alias da_sfJoystick_getAxisPosition = float function( uint, sfJoystickAxis );
    alias da_sfJoystick_getIdentification = sfJoystickIdentification function( uint );
    alias da_sfJoystick_update = void function();

    // Window/Keyboard.h
    alias da_sfKeyboard_isKeyPressed = sfBool function( sfKeyCode );

    // Window/Mouse.h
    alias da_sfMouse_isButtonPressed = sfBool function( sfMouseButton );
    alias da_sfMouse_getPosition = sfVector2i function( const( sfWindow )* );
    alias da_sfMouse_setPosition = void function( sfVector2i,const( sfWindow )* );

    // Window/Sensor.h
    alias da_sfSensor_isAvailable = sfBool function( sfSensorType );
    alias da_sfSensor_setEnabled = void function( sfSensorType,sfBool );
    alias da_sfSensor_getValue = sfVector3f function( sfSensorType );

    // Window/Touch.h
    alias da_sfTouch_isDown = sfBool function( uint );
    alias da_sfTouch_getPosition = sfVector2i function( uint, const( sfWindow )* );

    // Window/VideoMode.h
    alias da_sfVideoMode_getDesktopMode = sfVideoMode function();
    alias da_sfVideoMode_getFullscreenModes = const( sfVideoMode )* function( size_t* );
    alias da_sfVideoMode_isValid = sfBool function( sfVideoMode );

    // Window/Window.h
    alias da_sfWindow_create = sfWindow* function( sfVideoMode,const( char )*,sfUint32,const( sfContextSettings )* );
    alias da_sfWindow_createFromHandle = sfWindow* function( sfWindowHandle,const( sfContextSettings )* );
    alias da_sfWindow_destroy = void function( sfWindow* );
    alias da_sfWindow_close = void function( sfWindow* );
    alias da_sfWindow_isOpen = sfBool function( const( sfWindow )* );
    alias da_sfWindow_getSettings = sfContextSettings function( const( sfWindow )* );
    alias da_sfWindow_pollEvent = sfBool function( sfWindow*,sfEvent* );
    alias da_sfWindow_waitEvent = sfBool function( sfWindow*,sfEvent* );
    alias da_sfWindow_getPosition = sfVector2i function( const( sfWindow )* );
    alias da_sfWindow_setPosition = void function( sfWindow*,sfVector2i );
    alias da_sfWindow_getSize = sfVector2u function( const( sfWindow )* );
    alias da_sfWindow_setSize = void function( sfWindow*,sfVector2u );
    alias da_sfWindow_setTitle = void function( sfWindow*,const( char )* );
    alias da_sfWindow_setIcon = void function( sfWindow*,uint,uint,const( sfUint8 )* );
    alias da_sfWindow_setVisible = void function( sfWindow*,sfBool );
    alias da_sfWindow_setMouseCursorVisible = void function( sfWindow*,sfBool );
    alias da_sfWindow_setVerticalSyncEnabled = void function( sfWindow*,sfBool );
    alias da_sfWindow_setKeyRepeatEnabled = void function( sfWindow*,sfBool );
    alias da_sfWindow_setActive = sfBool function( sfWindow*,sfBool );
    alias da_sfWindow_requestFocus = void function( sfWindow* );
    alias da_sfWindow_hasFocus = void function( const( sfWindow )* );
    alias da_sfWindow_display = void function( sfWindow* );
    alias da_sfWindow_setFramerateLimit = void function( sfWindow*,uint );
    alias da_sfWindow_setJoystickThreshold = void function( sfWindow*,float );
    alias da_sfWindow_getSystemHandle = sfWindowHandle function( const( sfWindow )* );
}

__gshared {
    da_sfContext_create sfContext_create;
    da_sfContext_destroy sfContext_destroy;
    da_sfContext_setActive sfContext_setActive;

    da_sfJoystick_isConnected sfJoystick_isConnected;
    da_sfJoystick_getButtonCount sfJoystick_getButtonCount;
    da_sfJoystick_hasAxis sfJoystick_hasAxis;
    da_sfJoystick_isButtonPressed sfJoystick_isButtonPressed;
    da_sfJoystick_getAxisPosition sfJoystick_getAxisPosition;
    da_sfJoystick_getIdentification sfJoystick_getIdentification;
    da_sfJoystick_update sfJoystick_update;

    da_sfKeyboard_isKeyPressed sfKeyboard_isKeyPressed;

    da_sfMouse_isButtonPressed sfMouse_isButtonPressed;
    da_sfMouse_getPosition sfMouse_getPosition;
    da_sfMouse_setPosition sfMouse_setPosition;

    da_sfSensor_isAvailable sfSensor_isAvailable;
    da_sfSensor_setEnabled sfSensor_setEnabled;
    da_sfSensor_getValue sfSensor_getValue;

    da_sfTouch_isDown sfTouch_isDown;
    da_sfTouch_getPosition sfTouch_getPosition;

    da_sfVideoMode_getDesktopMode sfVideoMode_getDesktopMode;
    da_sfVideoMode_getFullscreenModes sfVideoMode_getFullscreenModes;
    da_sfVideoMode_isValid sfVideoMode_isValid;

    da_sfWindow_create sfWindow_create;
    da_sfWindow_createFromHandle sfWindow_createFromHandle;
    da_sfWindow_destroy sfWindow_destroy;
    da_sfWindow_close sfWindow_close;
    da_sfWindow_isOpen sfWindow_isOpen;
    da_sfWindow_getSettings sfWindow_getSettings;
    da_sfWindow_pollEvent sfWindow_pollEvent;
    da_sfWindow_waitEvent sfWindow_waitEvent;
    da_sfWindow_getPosition sfWindow_getPosition;
    da_sfWindow_setPosition sfWindow_setPosition;
    da_sfWindow_getSize sfWindow_getSize;
    da_sfWindow_setSize sfWindow_setSize;
    da_sfWindow_setTitle sfWindow_setTitle;
    da_sfWindow_setIcon sfWindow_setIcon;
    da_sfWindow_setVisible sfWindow_setVisible;
    da_sfWindow_setMouseCursorVisible sfWindow_setMouseCursorVisible;
    da_sfWindow_setVerticalSyncEnabled sfWindow_setVerticalSyncEnabled;
    da_sfWindow_setKeyRepeatEnabled sfWindow_setKeyRepeatEnabled;
    da_sfWindow_setActive sfWindow_setActive;
    da_sfWindow_requestFocus sfWindow_requestFocus;
    da_sfWindow_hasFocus sfWindow_hasFocus;
    da_sfWindow_display sfWindow_display;
    da_sfWindow_setFramerateLimit sfWindow_setFramerateLimit;
    da_sfWindow_setJoystickThreshold sfWindow_setJoystickThreshold;
    da_sfWindow_getSystemHandle sfWindow_getSystemHandle;
}

class DerelictSFML2WindowLoader : SharedLibLoader {
    public this() {
        super( libNames );
    }

    protected override void loadSymbols() {
        bindFunc( cast( void** )&sfContext_create, "sfContext_create" );
        bindFunc( cast( void** )&sfContext_destroy, "sfContext_destroy" );
        bindFunc( cast( void** )&sfContext_setActive, "sfContext_setActive" );
        bindFunc( cast( void** )&sfJoystick_isConnected, "sfJoystick_isConnected" );
        bindFunc( cast( void** )&sfJoystick_getButtonCount, "sfJoystick_getButtonCount" );
        bindFunc( cast( void** )&sfJoystick_hasAxis, "sfJoystick_hasAxis" );
        bindFunc( cast( void** )&sfJoystick_isButtonPressed, "sfJoystick_isButtonPressed" );
        bindFunc( cast( void** )&sfJoystick_getAxisPosition, "sfJoystick_getAxisPosition" );
        bindFunc( cast( void** )&sfJoystick_getIdentification, "sfJoystick_getIdentification" );
        bindFunc( cast( void** )&sfJoystick_update, "sfJoystick_update" );
        bindFunc( cast( void** )&sfKeyboard_isKeyPressed, "sfKeyboard_isKeyPressed" );
        bindFunc( cast( void** )&sfMouse_isButtonPressed, "sfMouse_isButtonPressed" );
        bindFunc( cast( void** )&sfMouse_getPosition, "sfMouse_getPosition" );
        bindFunc( cast( void** )&sfMouse_setPosition, "sfMouse_setPosition" );
        bindFunc( cast( void** )&sfSensor_isAvailable, "sfSensor_isAvailable" );
        bindFunc( cast( void** )&sfSensor_setEnabled, "sfSensor_setEnabled" );
        bindFunc( cast( void** )&sfSensor_getValue, "sfSensor_getValue" );
        bindFunc( cast( void** )&sfTouch_isDown, "sfTouch_isDown" );
        bindFunc( cast( void** )&sfTouch_getPosition, "sfTouch_getPosition" );
        bindFunc( cast( void** )&sfVideoMode_getDesktopMode, "sfVideoMode_getDesktopMode" );
        bindFunc( cast( void** )&sfVideoMode_getFullscreenModes, "sfVideoMode_getFullscreenModes" );
        bindFunc( cast( void** )&sfVideoMode_isValid, "sfVideoMode_isValid" );
        bindFunc( cast( void** )&sfWindow_create, "sfWindow_create" );
        bindFunc( cast( void** )&sfWindow_createFromHandle, "sfWindow_createFromHandle" );
        bindFunc( cast( void** )&sfWindow_destroy, "sfWindow_destroy" );
        bindFunc( cast( void** )&sfWindow_close, "sfWindow_close" );
        bindFunc( cast( void** )&sfWindow_isOpen, "sfWindow_isOpen" );
        bindFunc( cast( void** )&sfWindow_getSettings, "sfWindow_getSettings" );
        bindFunc( cast( void** )&sfWindow_pollEvent, "sfWindow_pollEvent" );
        bindFunc( cast( void** )&sfWindow_waitEvent, "sfWindow_waitEvent" );
        bindFunc( cast( void** )&sfWindow_getPosition, "sfWindow_getPosition" );
        bindFunc( cast( void** )&sfWindow_setPosition, "sfWindow_setPosition" );
        bindFunc( cast( void** )&sfWindow_getSize, "sfWindow_getSize" );
        bindFunc( cast( void** )&sfWindow_setSize, "sfWindow_setSize" );
        bindFunc( cast( void** )&sfWindow_setTitle, "sfWindow_setTitle" );
        bindFunc( cast( void** )&sfWindow_setIcon, "sfWindow_setIcon" );
        bindFunc( cast( void** )&sfWindow_setVisible, "sfWindow_setVisible" );
        bindFunc( cast( void** )&sfWindow_setMouseCursorVisible, "sfWindow_setMouseCursorVisible" );
        bindFunc( cast( void** )&sfWindow_setVerticalSyncEnabled, "sfWindow_setVerticalSyncEnabled" );
        bindFunc( cast( void** )&sfWindow_setKeyRepeatEnabled, "sfWindow_setKeyRepeatEnabled" );
        bindFunc( cast( void** )&sfWindow_setActive, "sfWindow_setActive" );
        bindFunc( cast( void** )&sfWindow_requestFocus, "sfWindow_requestFocus" );
        bindFunc( cast( void** )&sfWindow_hasFocus, "sfWindow_hasFocus" );
        bindFunc( cast( void** )&sfWindow_display, "sfWindow_display" );
        bindFunc( cast( void** )&sfWindow_setFramerateLimit, "sfWindow_setFramerateLimit" );
        bindFunc( cast( void** )&sfWindow_setJoystickThreshold, "sfWindow_setJoystickThreshold" );
        bindFunc( cast( void** )&sfWindow_getSystemHandle, "sfWindow_getSystemHandle" );
    }
}

__gshared DerelictSFML2WindowLoader DerelictSFML2Window;

shared static this() {
    DerelictSFML2Window = new DerelictSFML2WindowLoader();
}
