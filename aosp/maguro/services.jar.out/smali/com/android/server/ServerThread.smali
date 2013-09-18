.class Lcom/android/server/ServerThread;
.super Ljava/lang/Thread;
.source "SystemServer.java"


# static fields
.field private static final ENCRYPTED_STATE:Ljava/lang/String; = "1"

.field private static final ENCRYPTING_STATE:Ljava/lang/String; = "trigger_restart_min_framework"

.field private static final TAG:Ljava/lang/String; = "SystemServer"


# instance fields
.field mContentResolver:Landroid/content/ContentResolver;


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 69
    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method

.method static final startSystemUi(Landroid/content/Context;)V
    .locals 4
    .parameter "context"

    .prologue
    .line 880
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    .line 881
    .local v0, intent:Landroid/content/Intent;
    new-instance v1, Landroid/content/ComponentName;

    const-string v2, "com.android.systemui"

    const-string v3, "com.android.systemui.SystemUIService"

    invoke-direct {v1, v2, v3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 883
    const-string v1, "SystemServer"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Starting service: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Slog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 884
    invoke-virtual {p0, v0}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 885
    return-void
.end method


# virtual methods
.method reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V
    .locals 3
    .parameter "msg"
    .parameter "e"

    .prologue
    .line 77
    const-string v0, "SystemServer"

    const-string v1, "***********************************************"

    invoke-static {v0, v1}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 78
    const-string v0, "SystemServer"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "BOOT FAILURE "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, p2}, Landroid/util/Log;->wtf(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 79
    return-void
.end method

.method public run()V
    .locals 117

    .prologue
    .line 83
    const/16 v3, 0xbc2

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v9

    invoke-static {v3, v9, v10}, Landroid/util/EventLog;->writeEvent(IJ)I

    .line 86
    invoke-static {}, Landroid/os/Looper;->prepare()V

    .line 88
    const/4 v3, -0x2

    invoke-static {v3}, Landroid/os/Process;->setThreadPriority(I)V

    .line 91
    const/4 v3, 0x1

    invoke-static {v3}, Lcom/android/internal/os/BinderInternal;->disableBackgroundScheduling(Z)V

    .line 92
    const/4 v3, 0x0

    invoke-static {v3}, Landroid/os/Process;->setCanSelfBackground(Z)V

    .line 96
    const-string v3, "sys.shutdown.requested"

    const-string v9, ""

    invoke-static {v3, v9}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v96

    .line 98
    .local v96, shutdownAction:Ljava/lang/String;
    if-eqz v96, :cond_0

    invoke-virtual/range {v96 .. v96}, Ljava/lang/String;->length()I

    move-result v3

    if-lez v3, :cond_0

    .line 99
    const/4 v3, 0x0

    move-object/from16 v0, v96

    invoke-virtual {v0, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    const/16 v9, 0x31

    if-ne v3, v9, :cond_c

    const/16 v90, 0x1

    .line 102
    .local v90, reboot:Z
    :goto_0
    invoke-virtual/range {v96 .. v96}, Ljava/lang/String;->length()I

    move-result v3

    const/4 v9, 0x1

    if-le v3, v9, :cond_d

    .line 103
    const/4 v3, 0x1

    invoke-virtual/range {v96 .. v96}, Ljava/lang/String;->length()I

    move-result v9

    move-object/from16 v0, v96

    invoke-virtual {v0, v3, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v89

    .line 108
    .local v89, reason:Ljava/lang/String;
    :goto_1
    move/from16 v0, v90

    move-object/from16 v1, v89

    invoke-static {v0, v1}, Lcom/android/server/pm/ShutdownThread;->rebootOrShutdown(ZLjava/lang/String;)V

    .line 112
    .end local v89           #reason:Ljava/lang/String;
    .end local v90           #reboot:Z
    :cond_0
    const-string v3, "ro.factorytest"

    invoke-static {v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v66

    .line 113
    .local v66, factoryTestStr:Ljava/lang/String;
    const-string v3, ""

    move-object/from16 v0, v66

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_e

    const/16 v65, 0x0

    .line 115
    .local v65, factoryTest:I
    :goto_2
    const-string v3, "1"

    const-string v9, "ro.config.headless"

    const-string v10, "0"

    invoke-static {v9, v10}, Landroid/os/SystemProperties;->get(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v3, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v16

    .line 117
    .local v16, headless:Z
    const/16 v71, 0x0

    .line 118
    .local v71, lights:Lcom/android/server/LightsService;
    const/16 v88, 0x0

    .line 119
    .local v88, power:Lcom/android/server/PowerManagerService;
    const/16 v44, 0x0

    .line 120
    .local v44, battery:Lcom/android/server/BatteryService;
    const/16 v107, 0x0

    .line 121
    .local v107, vibrator:Lcom/android/server/VibratorService;
    const/16 v41, 0x0

    .line 122
    .local v41, alarm:Lcom/android/server/AlarmManagerService;
    const/4 v13, 0x0

    .line 123
    .local v13, networkManagement:Lcom/android/server/NetworkManagementService;
    const/4 v12, 0x0

    .line 124
    .local v12, networkStats:Lcom/android/server/net/NetworkStatsService;
    const/16 v80, 0x0

    .line 125
    .local v80, networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    const/16 v53, 0x0

    .line 126
    .local v53, connectivity:Lcom/android/server/ConnectivityService;
    const/16 v114, 0x0

    .line 127
    .local v114, wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    const/16 v112, 0x0

    .line 128
    .local v112, wifi:Lcom/android/server/WifiService;
    const/16 v95, 0x0

    .line 129
    .local v95, serviceDiscovery:Lcom/android/server/NsdService;
    const/16 v87, 0x0

    .line 130
    .local v87, pm:Landroid/content/pm/IPackageManager;
    const/4 v4, 0x0

    .line 131
    .local v4, context:Landroid/content/Context;
    const/16 v116, 0x0

    .line 132
    .local v116, wm:Lcom/android/server/wm/WindowManagerService;
    const/16 v45, 0x0

    .line 133
    .local v45, bluetooth:Landroid/server/BluetoothService;
    const/16 v47, 0x0

    .line 134
    .local v47, bluetoothA2dp:Landroid/server/BluetoothA2dpService;
    const/16 v60, 0x0

    .line 135
    .local v60, dock:Lcom/android/server/DockObserver;
    const/16 v105, 0x0

    .line 136
    .local v105, usb:Lcom/android/server/usb/UsbService;
    const/16 v93, 0x0

    .line 137
    .local v93, serial:Lcom/android/server/SerialService;
    const/16 v103, 0x0

    .line 138
    .local v103, uiMode:Lcom/android/server/UiModeManagerService;
    const/16 v91, 0x0

    .line 139
    .local v91, recognition:Lcom/android/server/RecognitionManagerService;
    const/16 v99, 0x0

    .line 140
    .local v99, throttle:Lcom/android/server/ThrottleService;
    const/16 v82, 0x0

    .line 141
    .local v82, networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    const/16 v50, 0x0

    .line 142
    .local v50, commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    const/16 v70, 0x0

    .line 146
    .local v70, inputManager:Lcom/android/server/input/InputManagerService;
    :try_start_0
    const-string v3, "SystemServer"

    const-string v9, "Entropy Mixer"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 147
    const-string v3, "entropy"

    new-instance v9, Lcom/android/server/EntropyMixer;

    invoke-direct {v9}, Lcom/android/server/EntropyMixer;-><init>()V

    invoke-static {v3, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 149
    const-string v3, "SystemServer"

    const-string v9, "Power Manager"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 150
    new-instance v6, Lcom/android/server/PowerManagerService;

    invoke-direct {v6}, Lcom/android/server/PowerManagerService;-><init>()V
    :try_end_0
    .catch Ljava/lang/RuntimeException; {:try_start_0 .. :try_end_0} :catch_49

    .line 151
    .end local v88           #power:Lcom/android/server/PowerManagerService;
    .local v6, power:Lcom/android/server/PowerManagerService;
    :try_start_1
    const-string v3, "power"

    invoke-static {v3, v6}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 153
    const-string v3, "SystemServer"

    const-string v9, "Activity Manager"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 154
    invoke-static/range {v65 .. v65}, Lcom/android/server/am/ActivityManagerService;->main(I)Landroid/content/Context;

    move-result-object v4

    .line 156
    const-string v3, "SystemServer"

    const-string v9, "Telephony Registry"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 157
    const-string v3, "telephony.registry"

    new-instance v9, Lcom/android/server/TelephonyRegistry;

    invoke-direct {v9, v4}, Lcom/android/server/TelephonyRegistry;-><init>(Landroid/content/Context;)V

    invoke-static {v3, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 159
    const-string v3, "SystemServer"

    const-string v9, "Scheduling Policy"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 160
    const-string v3, "scheduling_policy"

    new-instance v9, Landroid/os/SchedulingPolicyService;

    invoke-direct {v9}, Landroid/os/SchedulingPolicyService;-><init>()V

    invoke-static {v3, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 163
    invoke-static {v4}, Lcom/android/server/AttributeCache;->init(Landroid/content/Context;)V

    .line 165
    const-string v3, "SystemServer"

    const-string v9, "Package Manager"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 167
    const-string v3, "vold.decrypt"

    invoke-static {v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v57

    .line 168
    .local v57, cryptState:Ljava/lang/String;
    const/16 v86, 0x0

    .line 169
    .local v86, onlyCore:Z
    const-string v3, "trigger_restart_min_framework"

    move-object/from16 v0, v57

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_f

    .line 170
    const-string v3, "SystemServer"

    const-string v9, "Detected encryption in progress - only parsing core apps"

    invoke-static {v3, v9}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 171
    const/16 v86, 0x1

    .line 177
    :cond_1
    :goto_3
    if-eqz v65, :cond_10

    const/4 v3, 0x1

    :goto_4
    move/from16 v0, v86

    invoke-static {v4, v3, v0}, Lcom/android/server/pm/PackageManagerService;->main(Landroid/content/Context;ZZ)Landroid/content/pm/IPackageManager;
    :try_end_1
    .catch Ljava/lang/RuntimeException; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v87

    .line 180
    const/16 v67, 0x0

    .line 182
    .local v67, firstBoot:Z
    :try_start_2
    invoke-interface/range {v87 .. v87}, Landroid/content/pm/IPackageManager;->isFirstBoot()Z
    :try_end_2
    .catch Landroid/os/RemoteException; {:try_start_2 .. :try_end_2} :catch_32
    .catch Ljava/lang/RuntimeException; {:try_start_2 .. :try_end_2} :catch_1

    move-result v67

    .line 186
    :goto_5
    :try_start_3
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->setSystemProcess()V

    .line 188
    invoke-virtual {v4}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    move-object/from16 v0, p0

    iput-object v3, v0, Lcom/android/server/ServerThread;->mContentResolver:Landroid/content/ContentResolver;
    :try_end_3
    .catch Ljava/lang/RuntimeException; {:try_start_3 .. :try_end_3} :catch_1

    .line 192
    :try_start_4
    const-string v3, "SystemServer"

    const-string v9, "Account Manager"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 193
    const-string v3, "account"

    new-instance v9, Landroid/accounts/AccountManagerService;

    invoke-direct {v9, v4}, Landroid/accounts/AccountManagerService;-><init>(Landroid/content/Context;)V

    invoke-static {v3, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_0
    .catch Ljava/lang/RuntimeException; {:try_start_4 .. :try_end_4} :catch_1

    .line 199
    :goto_6
    :try_start_5
    const-string v3, "SystemServer"

    const-string v9, "Content Manager"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 200
    const/4 v3, 0x1

    move/from16 v0, v65

    if-ne v0, v3, :cond_11

    const/4 v3, 0x1

    :goto_7
    invoke-static {v4, v3}, Landroid/content/ContentService;->main(Landroid/content/Context;Z)Landroid/content/IContentService;

    .line 203
    const-string v3, "SystemServer"

    const-string v9, "System Content Providers"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 204
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->installSystemProviders()V

    .line 206
    const-string v3, "SystemServer"

    const-string v9, "Lights Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 207
    new-instance v72, Lcom/android/server/LightsService;

    move-object/from16 v0, v72

    invoke-direct {v0, v4}, Lcom/android/server/LightsService;-><init>(Landroid/content/Context;)V
    :try_end_5
    .catch Ljava/lang/RuntimeException; {:try_start_5 .. :try_end_5} :catch_1

    .line 209
    .end local v71           #lights:Lcom/android/server/LightsService;
    .local v72, lights:Lcom/android/server/LightsService;
    :try_start_6
    const-string v3, "SystemServer"

    const-string v9, "Battery Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 210
    new-instance v5, Lcom/android/server/BatteryService;

    move-object/from16 v0, v72

    invoke-direct {v5, v4, v0}, Lcom/android/server/BatteryService;-><init>(Landroid/content/Context;Lcom/android/server/LightsService;)V
    :try_end_6
    .catch Ljava/lang/RuntimeException; {:try_start_6 .. :try_end_6} :catch_4a

    .line 211
    .end local v44           #battery:Lcom/android/server/BatteryService;
    .local v5, battery:Lcom/android/server/BatteryService;
    :try_start_7
    const-string v3, "battery"

    invoke-static {v3, v5}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 213
    const-string v3, "SystemServer"

    const-string v9, "Vibrator Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 214
    new-instance v108, Lcom/android/server/VibratorService;

    move-object/from16 v0, v108

    invoke-direct {v0, v4}, Lcom/android/server/VibratorService;-><init>(Landroid/content/Context;)V
    :try_end_7
    .catch Ljava/lang/RuntimeException; {:try_start_7 .. :try_end_7} :catch_4b

    .line 215
    .end local v107           #vibrator:Lcom/android/server/VibratorService;
    .local v108, vibrator:Lcom/android/server/VibratorService;
    :try_start_8
    const-string v3, "vibrator"

    move-object/from16 v0, v108

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 219
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v3

    move-object/from16 v0, v72

    invoke-virtual {v6, v4, v0, v3, v5}, Lcom/android/server/PowerManagerService;->init(Landroid/content/Context;Lcom/android/server/LightsService;Landroid/app/IActivityManager;Lcom/android/server/BatteryService;)V

    .line 221
    const-string v3, "SystemServer"

    const-string v9, "Alarm Manager"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 222
    new-instance v7, Lcom/android/server/AlarmManagerService;

    invoke-direct {v7, v4}, Lcom/android/server/AlarmManagerService;-><init>(Landroid/content/Context;)V
    :try_end_8
    .catch Ljava/lang/RuntimeException; {:try_start_8 .. :try_end_8} :catch_4c

    .line 223
    .end local v41           #alarm:Lcom/android/server/AlarmManagerService;
    .local v7, alarm:Lcom/android/server/AlarmManagerService;
    :try_start_9
    const-string v3, "alarm"

    invoke-static {v3, v7}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 225
    const-string v3, "SystemServer"

    const-string v9, "Init Watchdog"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 226
    invoke-static {}, Lcom/android/server/Watchdog;->getInstance()Lcom/android/server/Watchdog;

    move-result-object v3

    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v8

    invoke-virtual/range {v3 .. v8}, Lcom/android/server/Watchdog;->init(Landroid/content/Context;Lcom/android/server/BatteryService;Lcom/android/server/PowerManagerService;Lcom/android/server/AlarmManagerService;Lcom/android/server/am/ActivityManagerService;)V

    .line 229
    const-string v3, "SystemServer"

    const-string v9, "Window Manager"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 230
    const/4 v3, 0x1

    move/from16 v0, v65

    if-eq v0, v3, :cond_12

    const/4 v3, 0x1

    move v9, v3

    :goto_8
    if-nez v67, :cond_13

    const/4 v3, 0x1

    :goto_9
    move/from16 v0, v86

    invoke-static {v4, v6, v9, v3, v0}, Lcom/android/server/wm/WindowManagerService;->main(Landroid/content/Context;Lcom/android/server/PowerManagerService;ZZZ)Lcom/android/server/wm/WindowManagerService;

    move-result-object v116

    .line 233
    const-string v3, "window"

    move-object/from16 v0, v116

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 234
    invoke-virtual/range {v116 .. v116}, Lcom/android/server/wm/WindowManagerService;->getInputManagerService()Lcom/android/server/input/InputManagerService;

    move-result-object v70

    .line 235
    const-string v3, "input"

    move-object/from16 v0, v70

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 237
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v3

    move-object/from16 v0, v116

    invoke-virtual {v3, v0}, Lcom/android/server/am/ActivityManagerService;->setWindowManager(Lcom/android/server/wm/WindowManagerService;)V

    .line 242
    const-string v3, "ro.kernel.qemu"

    invoke-static {v3}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v9, "1"

    invoke-virtual {v3, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_14

    .line 243
    const-string v3, "SystemServer"

    const-string v9, "No Bluetooh Service (emulator)"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_9
    .catch Ljava/lang/RuntimeException; {:try_start_9 .. :try_end_9} :catch_2

    :goto_a
    move-object/from16 v107, v108

    .end local v108           #vibrator:Lcom/android/server/VibratorService;
    .restart local v107       #vibrator:Lcom/android/server/VibratorService;
    move-object/from16 v71, v72

    .line 271
    .end local v57           #cryptState:Ljava/lang/String;
    .end local v67           #firstBoot:Z
    .end local v72           #lights:Lcom/android/server/LightsService;
    .end local v86           #onlyCore:Z
    .restart local v71       #lights:Lcom/android/server/LightsService;
    :goto_b
    const/16 v58, 0x0

    .line 272
    .local v58, devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    const/16 v97, 0x0

    .line 273
    .local v97, statusBar:Lcom/android/server/StatusBarManagerService;
    const/16 v68, 0x0

    .line 274
    .local v68, imm:Lcom/android/server/InputMethodManagerService;
    const/16 v42, 0x0

    .line 275
    .local v42, appWidget:Lcom/android/server/AppWidgetService;
    const/16 v84, 0x0

    .line 276
    .local v84, notification:Lcom/android/server/NotificationManagerService;
    const/16 v110, 0x0

    .line 277
    .local v110, wallpaper:Lcom/android/server/WallpaperManagerService;
    const/16 v73, 0x0

    .line 278
    .local v73, location:Lcom/android/server/LocationManagerService;
    const/16 v55, 0x0

    .line 279
    .local v55, countryDetector:Lcom/android/server/CountryDetectorService;
    const/16 v101, 0x0

    .line 280
    .local v101, tsms:Lcom/android/server/TextServicesManagerService;
    const/16 v75, 0x0

    .line 281
    .local v75, lockSettings:Lcom/android/internal/widget/LockSettingsService;
    const/16 v62, 0x0

    .line 284
    .local v62, dreamy:Landroid/service/dreams/DreamManagerService;
    const/4 v3, 0x1

    move/from16 v0, v65

    if-eq v0, v3, :cond_2

    .line 286
    :try_start_a
    const-string v3, "SystemServer"

    const-string v9, "Input Method Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 287
    new-instance v69, Lcom/android/server/InputMethodManagerService;

    move-object/from16 v0, v69

    move-object/from16 v1, v116

    invoke-direct {v0, v4, v1}, Lcom/android/server/InputMethodManagerService;-><init>(Landroid/content/Context;Lcom/android/server/wm/WindowManagerService;)V
    :try_end_a
    .catch Ljava/lang/Throwable; {:try_start_a .. :try_end_a} :catch_3

    .line 288
    .end local v68           #imm:Lcom/android/server/InputMethodManagerService;
    .local v69, imm:Lcom/android/server/InputMethodManagerService;
    :try_start_b
    const-string v3, "input_method"

    move-object/from16 v0, v69

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_b
    .catch Ljava/lang/Throwable; {:try_start_b .. :try_end_b} :catch_48

    move-object/from16 v68, v69

    .line 294
    .end local v69           #imm:Lcom/android/server/InputMethodManagerService;
    .restart local v68       #imm:Lcom/android/server/InputMethodManagerService;
    :goto_c
    :try_start_c
    const-string v3, "SystemServer"

    const-string v9, "Accessibility Manager"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 295
    const-string v3, "accessibility"

    new-instance v9, Lcom/android/server/accessibility/AccessibilityManagerService;

    invoke-direct {v9, v4}, Lcom/android/server/accessibility/AccessibilityManagerService;-><init>(Landroid/content/Context;)V

    invoke-static {v3, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_c
    .catch Ljava/lang/Throwable; {:try_start_c .. :try_end_c} :catch_4

    .line 303
    :cond_2
    :goto_d
    :try_start_d
    invoke-virtual/range {v116 .. v116}, Lcom/android/server/wm/WindowManagerService;->displayReady()V
    :try_end_d
    .catch Ljava/lang/Throwable; {:try_start_d .. :try_end_d} :catch_5

    .line 309
    :goto_e
    :try_start_e
    invoke-interface/range {v87 .. v87}, Landroid/content/pm/IPackageManager;->performBootDexOpt()V
    :try_end_e
    .catch Ljava/lang/Throwable; {:try_start_e .. :try_end_e} :catch_6

    .line 315
    :goto_f
    :try_start_f
    invoke-static {}, Landroid/app/ActivityManagerNative;->getDefault()Landroid/app/IActivityManager;

    move-result-object v3

    invoke-virtual {v4}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v9

    const v10, 0x10403e5

    invoke-virtual {v9, v10}, Landroid/content/res/Resources;->getText(I)Ljava/lang/CharSequence;

    move-result-object v9

    const/4 v10, 0x0

    invoke-interface {v3, v9, v10}, Landroid/app/IActivityManager;->showBootMessage(Ljava/lang/CharSequence;Z)V
    :try_end_f
    .catch Landroid/os/RemoteException; {:try_start_f .. :try_end_f} :catch_47

    .line 322
    :goto_10
    const/4 v3, 0x1

    move/from16 v0, v65

    if-eq v0, v3, :cond_19

    .line 323
    const/16 v78, 0x0

    .line 324
    .local v78, mountService:Lcom/android/server/MountService;
    const-string v3, "0"

    const-string v9, "system_init.startmountservice"

    invoke-static {v9}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v3, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    .line 330
    :try_start_10
    const-string v3, "SystemServer"

    const-string v9, "Mount Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 331
    new-instance v79, Lcom/android/server/MountService;

    move-object/from16 v0, v79

    invoke-direct {v0, v4}, Lcom/android/server/MountService;-><init>(Landroid/content/Context;)V
    :try_end_10
    .catch Ljava/lang/Throwable; {:try_start_10 .. :try_end_10} :catch_7

    .line 332
    .end local v78           #mountService:Lcom/android/server/MountService;
    .local v79, mountService:Lcom/android/server/MountService;
    :try_start_11
    const-string v3, "mount"

    move-object/from16 v0, v79

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_11
    .catch Ljava/lang/Throwable; {:try_start_11 .. :try_end_11} :catch_46

    move-object/from16 v78, v79

    .line 339
    .end local v79           #mountService:Lcom/android/server/MountService;
    .restart local v78       #mountService:Lcom/android/server/MountService;
    :cond_3
    :goto_11
    :try_start_12
    const-string v3, "SystemServer"

    const-string v9, "LockSettingsService"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 340
    new-instance v76, Lcom/android/internal/widget/LockSettingsService;

    move-object/from16 v0, v76

    invoke-direct {v0, v4}, Lcom/android/internal/widget/LockSettingsService;-><init>(Landroid/content/Context;)V
    :try_end_12
    .catch Ljava/lang/Throwable; {:try_start_12 .. :try_end_12} :catch_8

    .line 341
    .end local v75           #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    .local v76, lockSettings:Lcom/android/internal/widget/LockSettingsService;
    :try_start_13
    const-string v3, "lock_settings"

    move-object/from16 v0, v76

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_13
    .catch Ljava/lang/Throwable; {:try_start_13 .. :try_end_13} :catch_45

    move-object/from16 v75, v76

    .line 347
    .end local v76           #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    .restart local v75       #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    :goto_12
    :try_start_14
    const-string v3, "SystemServer"

    const-string v9, "Device Policy"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 348
    new-instance v59, Lcom/android/server/DevicePolicyManagerService;

    move-object/from16 v0, v59

    invoke-direct {v0, v4}, Lcom/android/server/DevicePolicyManagerService;-><init>(Landroid/content/Context;)V
    :try_end_14
    .catch Ljava/lang/Throwable; {:try_start_14 .. :try_end_14} :catch_9

    .line 349
    .end local v58           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .local v59, devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    :try_start_15
    const-string v3, "device_policy"

    move-object/from16 v0, v59

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_15
    .catch Ljava/lang/Throwable; {:try_start_15 .. :try_end_15} :catch_44

    move-object/from16 v58, v59

    .line 355
    .end local v59           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .restart local v58       #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    :goto_13
    :try_start_16
    const-string v3, "SystemServer"

    const-string v9, "Status Bar"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 356
    new-instance v98, Lcom/android/server/StatusBarManagerService;

    move-object/from16 v0, v98

    move-object/from16 v1, v116

    invoke-direct {v0, v4, v1}, Lcom/android/server/StatusBarManagerService;-><init>(Landroid/content/Context;Lcom/android/server/wm/WindowManagerService;)V
    :try_end_16
    .catch Ljava/lang/Throwable; {:try_start_16 .. :try_end_16} :catch_a

    .line 357
    .end local v97           #statusBar:Lcom/android/server/StatusBarManagerService;
    .local v98, statusBar:Lcom/android/server/StatusBarManagerService;
    :try_start_17
    const-string v3, "statusbar"

    move-object/from16 v0, v98

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_17
    .catch Ljava/lang/Throwable; {:try_start_17 .. :try_end_17} :catch_43

    move-object/from16 v97, v98

    .line 363
    .end local v98           #statusBar:Lcom/android/server/StatusBarManagerService;
    .restart local v97       #statusBar:Lcom/android/server/StatusBarManagerService;
    :goto_14
    :try_start_18
    const-string v3, "SystemServer"

    const-string v9, "Clipboard Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 364
    const-string v3, "clipboard"

    new-instance v9, Lcom/android/server/ClipboardService;

    invoke-direct {v9, v4}, Lcom/android/server/ClipboardService;-><init>(Landroid/content/Context;)V

    invoke-static {v3, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_18
    .catch Ljava/lang/Throwable; {:try_start_18 .. :try_end_18} :catch_b

    .line 371
    :goto_15
    :try_start_19
    const-string v3, "SystemServer"

    const-string v9, "NetworkManagement Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 372
    invoke-static {v4}, Lcom/android/server/NetworkManagementService;->create(Landroid/content/Context;)Lcom/android/server/NetworkManagementService;

    move-result-object v13

    .line 373
    const-string v3, "network_management"

    invoke-static {v3, v13}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_19
    .catch Ljava/lang/Throwable; {:try_start_19 .. :try_end_19} :catch_c

    .line 379
    :goto_16
    :try_start_1a
    const-string v3, "SystemServer"

    const-string v9, "Text Service Manager Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 380
    new-instance v102, Lcom/android/server/TextServicesManagerService;

    move-object/from16 v0, v102

    invoke-direct {v0, v4}, Lcom/android/server/TextServicesManagerService;-><init>(Landroid/content/Context;)V
    :try_end_1a
    .catch Ljava/lang/Throwable; {:try_start_1a .. :try_end_1a} :catch_d

    .line 381
    .end local v101           #tsms:Lcom/android/server/TextServicesManagerService;
    .local v102, tsms:Lcom/android/server/TextServicesManagerService;
    :try_start_1b
    const-string v3, "textservices"

    move-object/from16 v0, v102

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_1b
    .catch Ljava/lang/Throwable; {:try_start_1b .. :try_end_1b} :catch_42

    move-object/from16 v101, v102

    .line 387
    .end local v102           #tsms:Lcom/android/server/TextServicesManagerService;
    .restart local v101       #tsms:Lcom/android/server/TextServicesManagerService;
    :goto_17
    :try_start_1c
    const-string v3, "SystemServer"

    const-string v9, "NetworkStats Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 388
    new-instance v81, Lcom/android/server/net/NetworkStatsService;

    move-object/from16 v0, v81

    invoke-direct {v0, v4, v13, v7}, Lcom/android/server/net/NetworkStatsService;-><init>(Landroid/content/Context;Landroid/os/INetworkManagementService;Landroid/app/IAlarmManager;)V
    :try_end_1c
    .catch Ljava/lang/Throwable; {:try_start_1c .. :try_end_1c} :catch_e

    .line 389
    .end local v12           #networkStats:Lcom/android/server/net/NetworkStatsService;
    .local v81, networkStats:Lcom/android/server/net/NetworkStatsService;
    :try_start_1d
    const-string v3, "netstats"

    move-object/from16 v0, v81

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_1d
    .catch Ljava/lang/Throwable; {:try_start_1d .. :try_end_1d} :catch_41

    move-object/from16 v12, v81

    .line 395
    .end local v81           #networkStats:Lcom/android/server/net/NetworkStatsService;
    .restart local v12       #networkStats:Lcom/android/server/net/NetworkStatsService;
    :goto_18
    :try_start_1e
    const-string v3, "SystemServer"

    const-string v9, "NetworkPolicy Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 396
    new-instance v8, Lcom/android/server/net/NetworkPolicyManagerService;

    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v10

    move-object v9, v4

    move-object v11, v6

    invoke-direct/range {v8 .. v13}, Lcom/android/server/net/NetworkPolicyManagerService;-><init>(Landroid/content/Context;Landroid/app/IActivityManager;Landroid/os/IPowerManager;Landroid/net/INetworkStatsService;Landroid/os/INetworkManagementService;)V
    :try_end_1e
    .catch Ljava/lang/Throwable; {:try_start_1e .. :try_end_1e} :catch_f

    .line 399
    .end local v80           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .local v8, networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    :try_start_1f
    const-string v3, "netpolicy"

    invoke-static {v3, v8}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_1f
    .catch Ljava/lang/Throwable; {:try_start_1f .. :try_end_1f} :catch_40

    .line 405
    :goto_19
    :try_start_20
    const-string v3, "SystemServer"

    const-string v9, "Wi-Fi P2pService"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 406
    new-instance v115, Landroid/net/wifi/p2p/WifiP2pService;

    move-object/from16 v0, v115

    invoke-direct {v0, v4}, Landroid/net/wifi/p2p/WifiP2pService;-><init>(Landroid/content/Context;)V
    :try_end_20
    .catch Ljava/lang/Throwable; {:try_start_20 .. :try_end_20} :catch_10

    .line 407
    .end local v114           #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    .local v115, wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    :try_start_21
    const-string v3, "wifip2p"

    move-object/from16 v0, v115

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_21
    .catch Ljava/lang/Throwable; {:try_start_21 .. :try_end_21} :catch_3f

    move-object/from16 v114, v115

    .line 413
    .end local v115           #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    .restart local v114       #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    :goto_1a
    :try_start_22
    const-string v3, "SystemServer"

    const-string v9, "Wi-Fi Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 414
    new-instance v113, Lcom/android/server/WifiService;

    move-object/from16 v0, v113

    invoke-direct {v0, v4}, Lcom/android/server/WifiService;-><init>(Landroid/content/Context;)V
    :try_end_22
    .catch Ljava/lang/Throwable; {:try_start_22 .. :try_end_22} :catch_11

    .line 415
    .end local v112           #wifi:Lcom/android/server/WifiService;
    .local v113, wifi:Lcom/android/server/WifiService;
    :try_start_23
    const-string v3, "wifi"

    move-object/from16 v0, v113

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_23
    .catch Ljava/lang/Throwable; {:try_start_23 .. :try_end_23} :catch_3e

    move-object/from16 v112, v113

    .line 421
    .end local v113           #wifi:Lcom/android/server/WifiService;
    .restart local v112       #wifi:Lcom/android/server/WifiService;
    :goto_1b
    :try_start_24
    const-string v3, "SystemServer"

    const-string v9, "Connectivity Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 422
    new-instance v54, Lcom/android/server/ConnectivityService;

    move-object/from16 v0, v54

    invoke-direct {v0, v4, v13, v12, v8}, Lcom/android/server/ConnectivityService;-><init>(Landroid/content/Context;Landroid/os/INetworkManagementService;Landroid/net/INetworkStatsService;Landroid/net/INetworkPolicyManager;)V
    :try_end_24
    .catch Ljava/lang/Throwable; {:try_start_24 .. :try_end_24} :catch_12

    .line 424
    .end local v53           #connectivity:Lcom/android/server/ConnectivityService;
    .local v54, connectivity:Lcom/android/server/ConnectivityService;
    :try_start_25
    const-string v3, "connectivity"

    move-object/from16 v0, v54

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 425
    move-object/from16 v0, v54

    invoke-virtual {v12, v0}, Lcom/android/server/net/NetworkStatsService;->bindConnectivityManager(Landroid/net/IConnectivityManager;)V

    .line 426
    move-object/from16 v0, v54

    invoke-virtual {v8, v0}, Lcom/android/server/net/NetworkPolicyManagerService;->bindConnectivityManager(Landroid/net/IConnectivityManager;)V

    .line 427
    invoke-virtual/range {v112 .. v112}, Lcom/android/server/WifiService;->checkAndStartWifi()V

    .line 428
    invoke-virtual/range {v114 .. v114}, Landroid/net/wifi/p2p/WifiP2pService;->connectivityServiceReady()V
    :try_end_25
    .catch Ljava/lang/Throwable; {:try_start_25 .. :try_end_25} :catch_3d

    move-object/from16 v53, v54

    .line 434
    .end local v54           #connectivity:Lcom/android/server/ConnectivityService;
    .restart local v53       #connectivity:Lcom/android/server/ConnectivityService;
    :goto_1c
    :try_start_26
    const-string v3, "SystemServer"

    const-string v9, "Network Service Discovery Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 435
    invoke-static {v4}, Lcom/android/server/NsdService;->create(Landroid/content/Context;)Lcom/android/server/NsdService;

    move-result-object v95

    .line 436
    const-string v3, "servicediscovery"

    move-object/from16 v0, v95

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_26
    .catch Ljava/lang/Throwable; {:try_start_26 .. :try_end_26} :catch_13

    .line 443
    :goto_1d
    :try_start_27
    const-string v3, "SystemServer"

    const-string v9, "Throttle Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 444
    new-instance v100, Lcom/android/server/ThrottleService;

    move-object/from16 v0, v100

    invoke-direct {v0, v4}, Lcom/android/server/ThrottleService;-><init>(Landroid/content/Context;)V
    :try_end_27
    .catch Ljava/lang/Throwable; {:try_start_27 .. :try_end_27} :catch_14

    .line 445
    .end local v99           #throttle:Lcom/android/server/ThrottleService;
    .local v100, throttle:Lcom/android/server/ThrottleService;
    :try_start_28
    const-string v3, "throttle"

    move-object/from16 v0, v100

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_28
    .catch Ljava/lang/Throwable; {:try_start_28 .. :try_end_28} :catch_3c

    move-object/from16 v99, v100

    .line 452
    .end local v100           #throttle:Lcom/android/server/ThrottleService;
    .restart local v99       #throttle:Lcom/android/server/ThrottleService;
    :goto_1e
    :try_start_29
    const-string v3, "SystemServer"

    const-string v9, "UpdateLock Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 453
    const-string v3, "updatelock"

    new-instance v9, Lcom/android/server/UpdateLockService;

    invoke-direct {v9, v4}, Lcom/android/server/UpdateLockService;-><init>(Landroid/content/Context;)V

    invoke-static {v3, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_29
    .catch Ljava/lang/Throwable; {:try_start_29 .. :try_end_29} :catch_15

    .line 464
    :goto_1f
    if-eqz v78, :cond_4

    .line 465
    invoke-virtual/range {v78 .. v78}, Lcom/android/server/MountService;->waitForAsecScan()V

    .line 469
    :cond_4
    :try_start_2a
    const-string v3, "SystemServer"

    const-string v9, "Notification Manager"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 470
    new-instance v85, Lcom/android/server/NotificationManagerService;

    move-object/from16 v0, v85

    move-object/from16 v1, v97

    move-object/from16 v2, v71

    invoke-direct {v0, v4, v1, v2}, Lcom/android/server/NotificationManagerService;-><init>(Landroid/content/Context;Lcom/android/server/StatusBarManagerService;Lcom/android/server/LightsService;)V
    :try_end_2a
    .catch Ljava/lang/Throwable; {:try_start_2a .. :try_end_2a} :catch_16

    .line 471
    .end local v84           #notification:Lcom/android/server/NotificationManagerService;
    .local v85, notification:Lcom/android/server/NotificationManagerService;
    :try_start_2b
    const-string v3, "notification"

    move-object/from16 v0, v85

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 472
    move-object/from16 v0, v85

    invoke-virtual {v8, v0}, Lcom/android/server/net/NetworkPolicyManagerService;->bindNotificationManager(Landroid/app/INotificationManager;)V
    :try_end_2b
    .catch Ljava/lang/Throwable; {:try_start_2b .. :try_end_2b} :catch_3b

    move-object/from16 v84, v85

    .line 478
    .end local v85           #notification:Lcom/android/server/NotificationManagerService;
    .restart local v84       #notification:Lcom/android/server/NotificationManagerService;
    :goto_20
    :try_start_2c
    const-string v3, "SystemServer"

    const-string v9, "Device Storage Monitor"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 479
    const-string v3, "devicestoragemonitor"

    new-instance v9, Lcom/android/server/DeviceStorageMonitorService;

    invoke-direct {v9, v4}, Lcom/android/server/DeviceStorageMonitorService;-><init>(Landroid/content/Context;)V

    invoke-static {v3, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_2c
    .catch Ljava/lang/Throwable; {:try_start_2c .. :try_end_2c} :catch_17

    .line 486
    :goto_21
    :try_start_2d
    const-string v3, "SystemServer"

    const-string v9, "Location Manager"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 487
    new-instance v74, Lcom/android/server/LocationManagerService;

    move-object/from16 v0, v74

    invoke-direct {v0, v4}, Lcom/android/server/LocationManagerService;-><init>(Landroid/content/Context;)V
    :try_end_2d
    .catch Ljava/lang/Throwable; {:try_start_2d .. :try_end_2d} :catch_18

    .line 488
    .end local v73           #location:Lcom/android/server/LocationManagerService;
    .local v74, location:Lcom/android/server/LocationManagerService;
    :try_start_2e
    const-string v3, "location"

    move-object/from16 v0, v74

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_2e
    .catch Ljava/lang/Throwable; {:try_start_2e .. :try_end_2e} :catch_3a

    move-object/from16 v73, v74

    .line 494
    .end local v74           #location:Lcom/android/server/LocationManagerService;
    .restart local v73       #location:Lcom/android/server/LocationManagerService;
    :goto_22
    :try_start_2f
    const-string v3, "SystemServer"

    const-string v9, "Country Detector"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 495
    new-instance v56, Lcom/android/server/CountryDetectorService;

    move-object/from16 v0, v56

    invoke-direct {v0, v4}, Lcom/android/server/CountryDetectorService;-><init>(Landroid/content/Context;)V
    :try_end_2f
    .catch Ljava/lang/Throwable; {:try_start_2f .. :try_end_2f} :catch_19

    .line 496
    .end local v55           #countryDetector:Lcom/android/server/CountryDetectorService;
    .local v56, countryDetector:Lcom/android/server/CountryDetectorService;
    :try_start_30
    const-string v3, "country_detector"

    move-object/from16 v0, v56

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_30
    .catch Ljava/lang/Throwable; {:try_start_30 .. :try_end_30} :catch_39

    move-object/from16 v55, v56

    .line 502
    .end local v56           #countryDetector:Lcom/android/server/CountryDetectorService;
    .restart local v55       #countryDetector:Lcom/android/server/CountryDetectorService;
    :goto_23
    :try_start_31
    const-string v3, "SystemServer"

    const-string v9, "Search Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 503
    const-string v3, "search"

    new-instance v9, Landroid/server/search/SearchManagerService;

    invoke-direct {v9, v4}, Landroid/server/search/SearchManagerService;-><init>(Landroid/content/Context;)V

    invoke-static {v3, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_31
    .catch Ljava/lang/Throwable; {:try_start_31 .. :try_end_31} :catch_1a

    .line 510
    :goto_24
    :try_start_32
    const-string v3, "SystemServer"

    const-string v9, "DropBox Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 511
    const-string v3, "dropbox"

    new-instance v9, Lcom/android/server/DropBoxManagerService;

    new-instance v10, Ljava/io/File;

    const-string v11, "/data/system/dropbox"

    invoke-direct {v10, v11}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v9, v4, v10}, Lcom/android/server/DropBoxManagerService;-><init>(Landroid/content/Context;Ljava/io/File;)V

    invoke-static {v3, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_32
    .catch Ljava/lang/Throwable; {:try_start_32 .. :try_end_32} :catch_1b

    .line 517
    :goto_25
    invoke-virtual {v4}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    const v9, 0x1110024

    invoke-virtual {v3, v9}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v3

    if-eqz v3, :cond_5

    .line 520
    :try_start_33
    const-string v3, "SystemServer"

    const-string v9, "Wallpaper Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 521
    if-nez v16, :cond_5

    .line 522
    new-instance v111, Lcom/android/server/WallpaperManagerService;

    move-object/from16 v0, v111

    invoke-direct {v0, v4}, Lcom/android/server/WallpaperManagerService;-><init>(Landroid/content/Context;)V
    :try_end_33
    .catch Ljava/lang/Throwable; {:try_start_33 .. :try_end_33} :catch_1c

    .line 523
    .end local v110           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .local v111, wallpaper:Lcom/android/server/WallpaperManagerService;
    :try_start_34
    const-string v3, "wallpaper"

    move-object/from16 v0, v111

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_34
    .catch Ljava/lang/Throwable; {:try_start_34 .. :try_end_34} :catch_38

    move-object/from16 v110, v111

    .line 530
    .end local v111           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .restart local v110       #wallpaper:Lcom/android/server/WallpaperManagerService;
    :cond_5
    :goto_26
    const-string v3, "0"

    const-string v9, "system_init.startaudioservice"

    invoke-static {v9}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v3, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 532
    :try_start_35
    const-string v3, "SystemServer"

    const-string v9, "Audio Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 533
    const-string v3, "audio"

    new-instance v9, Landroid/media/AudioService;

    invoke-direct {v9, v4}, Landroid/media/AudioService;-><init>(Landroid/content/Context;)V

    invoke-static {v3, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_35
    .catch Ljava/lang/Throwable; {:try_start_35 .. :try_end_35} :catch_1d

    .line 540
    :cond_6
    :goto_27
    :try_start_36
    const-string v3, "SystemServer"

    const-string v9, "Dock Observer"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 542
    new-instance v61, Lcom/android/server/DockObserver;

    move-object/from16 v0, v61

    invoke-direct {v0, v4, v6}, Lcom/android/server/DockObserver;-><init>(Landroid/content/Context;Lcom/android/server/PowerManagerService;)V
    :try_end_36
    .catch Ljava/lang/Throwable; {:try_start_36 .. :try_end_36} :catch_1e

    .end local v60           #dock:Lcom/android/server/DockObserver;
    .local v61, dock:Lcom/android/server/DockObserver;
    move-object/from16 v60, v61

    .line 548
    .end local v61           #dock:Lcom/android/server/DockObserver;
    .restart local v60       #dock:Lcom/android/server/DockObserver;
    :goto_28
    :try_start_37
    const-string v3, "SystemServer"

    const-string v9, "Wired Accessory Observer"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 550
    new-instance v3, Lcom/android/server/WiredAccessoryObserver;

    invoke-direct {v3, v4}, Lcom/android/server/WiredAccessoryObserver;-><init>(Landroid/content/Context;)V
    :try_end_37
    .catch Ljava/lang/Throwable; {:try_start_37 .. :try_end_37} :catch_1f

    .line 556
    :goto_29
    :try_start_38
    const-string v3, "SystemServer"

    const-string v9, "USB Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 558
    new-instance v106, Lcom/android/server/usb/UsbService;

    move-object/from16 v0, v106

    invoke-direct {v0, v4}, Lcom/android/server/usb/UsbService;-><init>(Landroid/content/Context;)V
    :try_end_38
    .catch Ljava/lang/Throwable; {:try_start_38 .. :try_end_38} :catch_20

    .line 559
    .end local v105           #usb:Lcom/android/server/usb/UsbService;
    .local v106, usb:Lcom/android/server/usb/UsbService;
    :try_start_39
    const-string v3, "usb"

    move-object/from16 v0, v106

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_39
    .catch Ljava/lang/Throwable; {:try_start_39 .. :try_end_39} :catch_37

    move-object/from16 v105, v106

    .line 565
    .end local v106           #usb:Lcom/android/server/usb/UsbService;
    .restart local v105       #usb:Lcom/android/server/usb/UsbService;
    :goto_2a
    :try_start_3a
    const-string v3, "SystemServer"

    const-string v9, "Serial Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 567
    new-instance v94, Lcom/android/server/SerialService;

    move-object/from16 v0, v94

    invoke-direct {v0, v4}, Lcom/android/server/SerialService;-><init>(Landroid/content/Context;)V
    :try_end_3a
    .catch Ljava/lang/Throwable; {:try_start_3a .. :try_end_3a} :catch_21

    .line 568
    .end local v93           #serial:Lcom/android/server/SerialService;
    .local v94, serial:Lcom/android/server/SerialService;
    :try_start_3b
    const-string v3, "serial"

    move-object/from16 v0, v94

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_3b
    .catch Ljava/lang/Throwable; {:try_start_3b .. :try_end_3b} :catch_36

    move-object/from16 v93, v94

    .line 574
    .end local v94           #serial:Lcom/android/server/SerialService;
    .restart local v93       #serial:Lcom/android/server/SerialService;
    :goto_2b
    :try_start_3c
    const-string v3, "SystemServer"

    const-string v9, "UI Mode Manager Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 576
    new-instance v104, Lcom/android/server/UiModeManagerService;

    move-object/from16 v0, v104

    invoke-direct {v0, v4}, Lcom/android/server/UiModeManagerService;-><init>(Landroid/content/Context;)V
    :try_end_3c
    .catch Ljava/lang/Throwable; {:try_start_3c .. :try_end_3c} :catch_22

    .end local v103           #uiMode:Lcom/android/server/UiModeManagerService;
    .local v104, uiMode:Lcom/android/server/UiModeManagerService;
    move-object/from16 v103, v104

    .line 582
    .end local v104           #uiMode:Lcom/android/server/UiModeManagerService;
    .restart local v103       #uiMode:Lcom/android/server/UiModeManagerService;
    :goto_2c
    :try_start_3d
    const-string v3, "SystemServer"

    const-string v9, "Backup Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 583
    const-string v3, "backup"

    new-instance v9, Lcom/android/server/BackupManagerService;

    invoke-direct {v9, v4}, Lcom/android/server/BackupManagerService;-><init>(Landroid/content/Context;)V

    invoke-static {v3, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_3d
    .catch Ljava/lang/Throwable; {:try_start_3d .. :try_end_3d} :catch_23

    .line 590
    :goto_2d
    :try_start_3e
    const-string v3, "SystemServer"

    const-string v9, "AppWidget Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 591
    new-instance v43, Lcom/android/server/AppWidgetService;

    move-object/from16 v0, v43

    invoke-direct {v0, v4}, Lcom/android/server/AppWidgetService;-><init>(Landroid/content/Context;)V
    :try_end_3e
    .catch Ljava/lang/Throwable; {:try_start_3e .. :try_end_3e} :catch_24

    .line 592
    .end local v42           #appWidget:Lcom/android/server/AppWidgetService;
    .local v43, appWidget:Lcom/android/server/AppWidgetService;
    :try_start_3f
    const-string v3, "appwidget"

    move-object/from16 v0, v43

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_3f
    .catch Ljava/lang/Throwable; {:try_start_3f .. :try_end_3f} :catch_35

    move-object/from16 v42, v43

    .line 598
    .end local v43           #appWidget:Lcom/android/server/AppWidgetService;
    .restart local v42       #appWidget:Lcom/android/server/AppWidgetService;
    :goto_2e
    :try_start_40
    const-string v3, "SystemServer"

    const-string v9, "Recognition Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 599
    new-instance v92, Lcom/android/server/RecognitionManagerService;

    move-object/from16 v0, v92

    invoke-direct {v0, v4}, Lcom/android/server/RecognitionManagerService;-><init>(Landroid/content/Context;)V
    :try_end_40
    .catch Ljava/lang/Throwable; {:try_start_40 .. :try_end_40} :catch_25

    .end local v91           #recognition:Lcom/android/server/RecognitionManagerService;
    .local v92, recognition:Lcom/android/server/RecognitionManagerService;
    move-object/from16 v91, v92

    .line 605
    .end local v92           #recognition:Lcom/android/server/RecognitionManagerService;
    .restart local v91       #recognition:Lcom/android/server/RecognitionManagerService;
    :goto_2f
    :try_start_41
    const-string v3, "SystemServer"

    const-string v9, "DiskStats Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 606
    const-string v3, "diskstats"

    new-instance v9, Lcom/android/server/DiskStatsService;

    invoke-direct {v9, v4}, Lcom/android/server/DiskStatsService;-><init>(Landroid/content/Context;)V

    invoke-static {v3, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_41
    .catch Ljava/lang/Throwable; {:try_start_41 .. :try_end_41} :catch_26

    .line 616
    :goto_30
    :try_start_42
    const-string v3, "SystemServer"

    const-string v9, "SamplingProfiler Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 617
    const-string v3, "samplingprofiler"

    new-instance v9, Lcom/android/server/SamplingProfilerService;

    invoke-direct {v9, v4}, Lcom/android/server/SamplingProfilerService;-><init>(Landroid/content/Context;)V

    invoke-static {v3, v9}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_42
    .catch Ljava/lang/Throwable; {:try_start_42 .. :try_end_42} :catch_27

    .line 624
    :goto_31
    :try_start_43
    const-string v3, "SystemServer"

    const-string v9, "NetworkTimeUpdateService"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 625
    new-instance v83, Lcom/android/server/NetworkTimeUpdateService;

    move-object/from16 v0, v83

    invoke-direct {v0, v4}, Lcom/android/server/NetworkTimeUpdateService;-><init>(Landroid/content/Context;)V
    :try_end_43
    .catch Ljava/lang/Throwable; {:try_start_43 .. :try_end_43} :catch_28

    .end local v82           #networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    .local v83, networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    move-object/from16 v82, v83

    .line 631
    .end local v83           #networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    .restart local v82       #networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    :goto_32
    :try_start_44
    const-string v3, "SystemServer"

    const-string v9, "CommonTimeManagementService"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 632
    new-instance v51, Lcom/android/server/CommonTimeManagementService;

    move-object/from16 v0, v51

    invoke-direct {v0, v4}, Lcom/android/server/CommonTimeManagementService;-><init>(Landroid/content/Context;)V
    :try_end_44
    .catch Ljava/lang/Throwable; {:try_start_44 .. :try_end_44} :catch_29

    .line 633
    .end local v50           #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    .local v51, commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    :try_start_45
    const-string v3, "commontime_management"

    move-object/from16 v0, v51

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_45
    .catch Ljava/lang/Throwable; {:try_start_45 .. :try_end_45} :catch_34

    move-object/from16 v50, v51

    .line 639
    .end local v51           #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    .restart local v50       #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    :goto_33
    :try_start_46
    const-string v3, "SystemServer"

    const-string v9, "CertBlacklister"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 640
    new-instance v3, Lcom/android/server/CertBlacklister;

    invoke-direct {v3, v4}, Lcom/android/server/CertBlacklister;-><init>(Landroid/content/Context;)V
    :try_end_46
    .catch Ljava/lang/Throwable; {:try_start_46 .. :try_end_46} :catch_2a

    .line 645
    :goto_34
    invoke-virtual {v4}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    const v9, 0x1110038

    invoke-virtual {v3, v9}, Landroid/content/res/Resources;->getBoolean(I)Z

    move-result v3

    if-eqz v3, :cond_7

    .line 648
    :try_start_47
    const-string v3, "SystemServer"

    const-string v9, "Dreams Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 650
    new-instance v63, Landroid/service/dreams/DreamManagerService;

    move-object/from16 v0, v63

    invoke-direct {v0, v4}, Landroid/service/dreams/DreamManagerService;-><init>(Landroid/content/Context;)V
    :try_end_47
    .catch Ljava/lang/Throwable; {:try_start_47 .. :try_end_47} :catch_2b

    .line 651
    .end local v62           #dreamy:Landroid/service/dreams/DreamManagerService;
    .local v63, dreamy:Landroid/service/dreams/DreamManagerService;
    :try_start_48
    const-string v3, "dreams"

    move-object/from16 v0, v63

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V
    :try_end_48
    .catch Ljava/lang/Throwable; {:try_start_48 .. :try_end_48} :catch_33

    move-object/from16 v62, v63

    .line 660
    .end local v63           #dreamy:Landroid/service/dreams/DreamManagerService;
    .end local v78           #mountService:Lcom/android/server/MountService;
    .restart local v62       #dreamy:Landroid/service/dreams/DreamManagerService;
    :cond_7
    :goto_35
    invoke-virtual/range {v116 .. v116}, Lcom/android/server/wm/WindowManagerService;->detectSafeMode()Z

    move-result v28

    .line 661
    .local v28, safeMode:Z
    if-eqz v28, :cond_18

    .line 662
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v3

    invoke-virtual {v3}, Lcom/android/server/am/ActivityManagerService;->enterSafeMode()V

    .line 664
    const/4 v3, 0x1

    sput-boolean v3, Ldalvik/system/Zygote;->systemInSafeMode:Z

    .line 666
    invoke-static {}, Ldalvik/system/VMRuntime;->getRuntime()Ldalvik/system/VMRuntime;

    move-result-object v3

    invoke-virtual {v3}, Ldalvik/system/VMRuntime;->disableJitCompilation()V

    .line 675
    :goto_36
    :try_start_49
    invoke-virtual/range {v107 .. v107}, Lcom/android/server/VibratorService;->systemReady()V
    :try_end_49
    .catch Ljava/lang/Throwable; {:try_start_49 .. :try_end_49} :catch_2c

    .line 680
    :goto_37
    if-eqz v58, :cond_8

    .line 682
    :try_start_4a
    invoke-virtual/range {v58 .. v58}, Lcom/android/server/DevicePolicyManagerService;->systemReady()V
    :try_end_4a
    .catch Ljava/lang/Throwable; {:try_start_4a .. :try_end_4a} :catch_2d

    .line 688
    :cond_8
    :goto_38
    if-eqz v84, :cond_9

    .line 690
    :try_start_4b
    invoke-virtual/range {v84 .. v84}, Lcom/android/server/NotificationManagerService;->systemReady()V
    :try_end_4b
    .catch Ljava/lang/Throwable; {:try_start_4b .. :try_end_4b} :catch_2e

    .line 697
    :cond_9
    :goto_39
    :try_start_4c
    invoke-virtual/range {v116 .. v116}, Lcom/android/server/wm/WindowManagerService;->systemReady()V
    :try_end_4c
    .catch Ljava/lang/Throwable; {:try_start_4c .. :try_end_4c} :catch_2f

    .line 702
    :goto_3a
    if-eqz v28, :cond_a

    .line 703
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v3

    invoke-virtual {v3}, Lcom/android/server/am/ActivityManagerService;->showSafeModeOverlay()V

    .line 709
    :cond_a
    invoke-virtual/range {v116 .. v116}, Lcom/android/server/wm/WindowManagerService;->computeNewConfiguration()Landroid/content/res/Configuration;

    move-result-object v52

    .line 710
    .local v52, config:Landroid/content/res/Configuration;
    new-instance v77, Landroid/util/DisplayMetrics;

    invoke-direct/range {v77 .. v77}, Landroid/util/DisplayMetrics;-><init>()V

    .line 711
    .local v77, metrics:Landroid/util/DisplayMetrics;
    const-string v3, "window"

    invoke-virtual {v4, v3}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v109

    check-cast v109, Landroid/view/WindowManager;

    .line 712
    .local v109, w:Landroid/view/WindowManager;
    invoke-interface/range {v109 .. v109}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v3

    move-object/from16 v0, v77

    invoke-virtual {v3, v0}, Landroid/view/Display;->getMetrics(Landroid/util/DisplayMetrics;)V

    .line 713
    invoke-virtual {v4}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    move-object/from16 v0, v52

    move-object/from16 v1, v77

    invoke-virtual {v3, v0, v1}, Landroid/content/res/Resources;->updateConfiguration(Landroid/content/res/Configuration;Landroid/util/DisplayMetrics;)V

    .line 715
    invoke-virtual {v6}, Lcom/android/server/PowerManagerService;->systemReady()V

    .line 717
    :try_start_4d
    invoke-interface/range {v87 .. v87}, Landroid/content/pm/IPackageManager;->systemReady()V
    :try_end_4d
    .catch Ljava/lang/Throwable; {:try_start_4d .. :try_end_4d} :catch_30

    .line 722
    :goto_3b
    :try_start_4e
    invoke-virtual/range {v75 .. v75}, Lcom/android/internal/widget/LockSettingsService;->systemReady()V
    :try_end_4e
    .catch Ljava/lang/Throwable; {:try_start_4e .. :try_end_4e} :catch_31

    .line 728
    :goto_3c
    move-object/from16 v17, v4

    .line 729
    .local v17, contextF:Landroid/content/Context;
    move-object/from16 v18, v5

    .line 730
    .local v18, batteryF:Lcom/android/server/BatteryService;
    move-object/from16 v19, v13

    .line 731
    .local v19, networkManagementF:Lcom/android/server/NetworkManagementService;
    move-object/from16 v20, v12

    .line 732
    .local v20, networkStatsF:Lcom/android/server/net/NetworkStatsService;
    move-object/from16 v21, v8

    .line 733
    .local v21, networkPolicyF:Lcom/android/server/net/NetworkPolicyManagerService;
    move-object/from16 v22, v53

    .line 734
    .local v22, connectivityF:Lcom/android/server/ConnectivityService;
    move-object/from16 v23, v60

    .line 735
    .local v23, dockF:Lcom/android/server/DockObserver;
    move-object/from16 v24, v105

    .line 736
    .local v24, usbF:Lcom/android/server/usb/UsbService;
    move-object/from16 v34, v99

    .line 737
    .local v34, throttleF:Lcom/android/server/ThrottleService;
    move-object/from16 v25, v103

    .line 738
    .local v25, uiModeF:Lcom/android/server/UiModeManagerService;
    move-object/from16 v27, v42

    .line 739
    .local v27, appWidgetF:Lcom/android/server/AppWidgetService;
    move-object/from16 v29, v110

    .line 740
    .local v29, wallpaperF:Lcom/android/server/WallpaperManagerService;
    move-object/from16 v30, v68

    .line 741
    .local v30, immF:Lcom/android/server/InputMethodManagerService;
    move-object/from16 v26, v91

    .line 742
    .local v26, recognitionF:Lcom/android/server/RecognitionManagerService;
    move-object/from16 v32, v73

    .line 743
    .local v32, locationF:Lcom/android/server/LocationManagerService;
    move-object/from16 v33, v55

    .line 744
    .local v33, countryDetectorF:Lcom/android/server/CountryDetectorService;
    move-object/from16 v35, v82

    .line 745
    .local v35, networkTimeUpdaterF:Lcom/android/server/NetworkTimeUpdateService;
    move-object/from16 v36, v50

    .line 746
    .local v36, commonTimeMgmtServiceF:Lcom/android/server/CommonTimeManagementService;
    move-object/from16 v37, v101

    .line 747
    .local v37, textServiceManagerServiceF:Lcom/android/server/TextServicesManagerService;
    move-object/from16 v31, v97

    .line 748
    .local v31, statusBarF:Lcom/android/server/StatusBarManagerService;
    move-object/from16 v38, v62

    .line 749
    .local v38, dreamyF:Landroid/service/dreams/DreamManagerService;
    move-object/from16 v39, v70

    .line 750
    .local v39, inputManagerF:Lcom/android/server/input/InputManagerService;
    move-object/from16 v40, v45

    .line 757
    .local v40, bluetoothF:Landroid/server/BluetoothService;
    invoke-static {}, Lcom/android/server/am/ActivityManagerService;->self()Lcom/android/server/am/ActivityManagerService;

    move-result-object v3

    new-instance v14, Lcom/android/server/ServerThread$1;

    move-object/from16 v15, p0

    invoke-direct/range {v14 .. v40}, Lcom/android/server/ServerThread$1;-><init>(Lcom/android/server/ServerThread;ZLandroid/content/Context;Lcom/android/server/BatteryService;Lcom/android/server/NetworkManagementService;Lcom/android/server/net/NetworkStatsService;Lcom/android/server/net/NetworkPolicyManagerService;Lcom/android/server/ConnectivityService;Lcom/android/server/DockObserver;Lcom/android/server/usb/UsbService;Lcom/android/server/UiModeManagerService;Lcom/android/server/RecognitionManagerService;Lcom/android/server/AppWidgetService;ZLcom/android/server/WallpaperManagerService;Lcom/android/server/InputMethodManagerService;Lcom/android/server/StatusBarManagerService;Lcom/android/server/LocationManagerService;Lcom/android/server/CountryDetectorService;Lcom/android/server/ThrottleService;Lcom/android/server/NetworkTimeUpdateService;Lcom/android/server/CommonTimeManagementService;Lcom/android/server/TextServicesManagerService;Landroid/service/dreams/DreamManagerService;Lcom/android/server/input/InputManagerService;Landroid/server/BluetoothService;)V

    invoke-virtual {v3, v14}, Lcom/android/server/am/ActivityManagerService;->systemReady(Ljava/lang/Runnable;)V

    .line 871
    invoke-static {}, Landroid/os/StrictMode;->conditionallyEnableDebugLogging()Z

    move-result v3

    if-eqz v3, :cond_b

    .line 872
    const-string v3, "SystemServer"

    const-string v9, "Enabled StrictMode for system server main thread."

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 875
    :cond_b
    invoke-static {}, Landroid/os/Looper;->loop()V

    .line 876
    const-string v3, "SystemServer"

    const-string v9, "System ServerThread is exiting!"

    invoke-static {v3, v9}, Landroid/util/Slog;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 877
    return-void

    .line 99
    .end local v4           #context:Landroid/content/Context;
    .end local v5           #battery:Lcom/android/server/BatteryService;
    .end local v6           #power:Lcom/android/server/PowerManagerService;
    .end local v7           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v8           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .end local v12           #networkStats:Lcom/android/server/net/NetworkStatsService;
    .end local v13           #networkManagement:Lcom/android/server/NetworkManagementService;
    .end local v16           #headless:Z
    .end local v17           #contextF:Landroid/content/Context;
    .end local v18           #batteryF:Lcom/android/server/BatteryService;
    .end local v19           #networkManagementF:Lcom/android/server/NetworkManagementService;
    .end local v20           #networkStatsF:Lcom/android/server/net/NetworkStatsService;
    .end local v21           #networkPolicyF:Lcom/android/server/net/NetworkPolicyManagerService;
    .end local v22           #connectivityF:Lcom/android/server/ConnectivityService;
    .end local v23           #dockF:Lcom/android/server/DockObserver;
    .end local v24           #usbF:Lcom/android/server/usb/UsbService;
    .end local v25           #uiModeF:Lcom/android/server/UiModeManagerService;
    .end local v26           #recognitionF:Lcom/android/server/RecognitionManagerService;
    .end local v27           #appWidgetF:Lcom/android/server/AppWidgetService;
    .end local v28           #safeMode:Z
    .end local v29           #wallpaperF:Lcom/android/server/WallpaperManagerService;
    .end local v30           #immF:Lcom/android/server/InputMethodManagerService;
    .end local v31           #statusBarF:Lcom/android/server/StatusBarManagerService;
    .end local v32           #locationF:Lcom/android/server/LocationManagerService;
    .end local v33           #countryDetectorF:Lcom/android/server/CountryDetectorService;
    .end local v34           #throttleF:Lcom/android/server/ThrottleService;
    .end local v35           #networkTimeUpdaterF:Lcom/android/server/NetworkTimeUpdateService;
    .end local v36           #commonTimeMgmtServiceF:Lcom/android/server/CommonTimeManagementService;
    .end local v37           #textServiceManagerServiceF:Lcom/android/server/TextServicesManagerService;
    .end local v38           #dreamyF:Landroid/service/dreams/DreamManagerService;
    .end local v39           #inputManagerF:Lcom/android/server/input/InputManagerService;
    .end local v40           #bluetoothF:Landroid/server/BluetoothService;
    .end local v42           #appWidget:Lcom/android/server/AppWidgetService;
    .end local v45           #bluetooth:Landroid/server/BluetoothService;
    .end local v47           #bluetoothA2dp:Landroid/server/BluetoothA2dpService;
    .end local v50           #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    .end local v52           #config:Landroid/content/res/Configuration;
    .end local v53           #connectivity:Lcom/android/server/ConnectivityService;
    .end local v55           #countryDetector:Lcom/android/server/CountryDetectorService;
    .end local v58           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .end local v60           #dock:Lcom/android/server/DockObserver;
    .end local v62           #dreamy:Landroid/service/dreams/DreamManagerService;
    .end local v65           #factoryTest:I
    .end local v66           #factoryTestStr:Ljava/lang/String;
    .end local v68           #imm:Lcom/android/server/InputMethodManagerService;
    .end local v70           #inputManager:Lcom/android/server/input/InputManagerService;
    .end local v71           #lights:Lcom/android/server/LightsService;
    .end local v73           #location:Lcom/android/server/LocationManagerService;
    .end local v75           #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    .end local v77           #metrics:Landroid/util/DisplayMetrics;
    .end local v82           #networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    .end local v84           #notification:Lcom/android/server/NotificationManagerService;
    .end local v87           #pm:Landroid/content/pm/IPackageManager;
    .end local v91           #recognition:Lcom/android/server/RecognitionManagerService;
    .end local v93           #serial:Lcom/android/server/SerialService;
    .end local v95           #serviceDiscovery:Lcom/android/server/NsdService;
    .end local v97           #statusBar:Lcom/android/server/StatusBarManagerService;
    .end local v99           #throttle:Lcom/android/server/ThrottleService;
    .end local v101           #tsms:Lcom/android/server/TextServicesManagerService;
    .end local v103           #uiMode:Lcom/android/server/UiModeManagerService;
    .end local v105           #usb:Lcom/android/server/usb/UsbService;
    .end local v107           #vibrator:Lcom/android/server/VibratorService;
    .end local v109           #w:Landroid/view/WindowManager;
    .end local v110           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .end local v112           #wifi:Lcom/android/server/WifiService;
    .end local v114           #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    .end local v116           #wm:Lcom/android/server/wm/WindowManagerService;
    :cond_c
    const/16 v90, 0x0

    goto/16 :goto_0

    .line 105
    .restart local v90       #reboot:Z
    :cond_d
    const/16 v89, 0x0

    .restart local v89       #reason:Ljava/lang/String;
    goto/16 :goto_1

    .line 113
    .end local v89           #reason:Ljava/lang/String;
    .end local v90           #reboot:Z
    .restart local v66       #factoryTestStr:Ljava/lang/String;
    :cond_e
    invoke-static/range {v66 .. v66}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v65

    goto/16 :goto_2

    .line 172
    .restart local v4       #context:Landroid/content/Context;
    .restart local v6       #power:Lcom/android/server/PowerManagerService;
    .restart local v12       #networkStats:Lcom/android/server/net/NetworkStatsService;
    .restart local v13       #networkManagement:Lcom/android/server/NetworkManagementService;
    .restart local v16       #headless:Z
    .restart local v41       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v44       #battery:Lcom/android/server/BatteryService;
    .restart local v45       #bluetooth:Landroid/server/BluetoothService;
    .restart local v47       #bluetoothA2dp:Landroid/server/BluetoothA2dpService;
    .restart local v50       #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    .restart local v53       #connectivity:Lcom/android/server/ConnectivityService;
    .restart local v57       #cryptState:Ljava/lang/String;
    .restart local v60       #dock:Lcom/android/server/DockObserver;
    .restart local v65       #factoryTest:I
    .restart local v70       #inputManager:Lcom/android/server/input/InputManagerService;
    .restart local v71       #lights:Lcom/android/server/LightsService;
    .restart local v80       #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v82       #networkTimeUpdater:Lcom/android/server/NetworkTimeUpdateService;
    .restart local v86       #onlyCore:Z
    .restart local v87       #pm:Landroid/content/pm/IPackageManager;
    .restart local v91       #recognition:Lcom/android/server/RecognitionManagerService;
    .restart local v93       #serial:Lcom/android/server/SerialService;
    .restart local v95       #serviceDiscovery:Lcom/android/server/NsdService;
    .restart local v99       #throttle:Lcom/android/server/ThrottleService;
    .restart local v103       #uiMode:Lcom/android/server/UiModeManagerService;
    .restart local v105       #usb:Lcom/android/server/usb/UsbService;
    .restart local v107       #vibrator:Lcom/android/server/VibratorService;
    .restart local v112       #wifi:Lcom/android/server/WifiService;
    .restart local v114       #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    .restart local v116       #wm:Lcom/android/server/wm/WindowManagerService;
    :cond_f
    :try_start_4f
    const-string v3, "1"

    move-object/from16 v0, v57

    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 173
    const-string v3, "SystemServer"

    const-string v9, "Device encrypted - only parsing core apps"

    invoke-static {v3, v9}, Landroid/util/Slog;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 174
    const/16 v86, 0x1

    goto/16 :goto_3

    .line 177
    :cond_10
    const/4 v3, 0x0

    goto/16 :goto_4

    .line 195
    .restart local v67       #firstBoot:Z
    :catch_0
    move-exception v64

    .line 196
    .local v64, e:Ljava/lang/Throwable;
    const-string v3, "SystemServer"

    const-string v9, "Failure starting Account Manager"

    move-object/from16 v0, v64

    invoke-static {v3, v9, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I
    :try_end_4f
    .catch Ljava/lang/RuntimeException; {:try_start_4f .. :try_end_4f} :catch_1

    goto/16 :goto_6

    .line 266
    .end local v57           #cryptState:Ljava/lang/String;
    .end local v64           #e:Ljava/lang/Throwable;
    .end local v67           #firstBoot:Z
    .end local v86           #onlyCore:Z
    :catch_1
    move-exception v64

    move-object/from16 v7, v41

    .end local v41           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v7       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v5, v44

    .line 267
    .end local v44           #battery:Lcom/android/server/BatteryService;
    .restart local v5       #battery:Lcom/android/server/BatteryService;
    .local v64, e:Ljava/lang/RuntimeException;
    :goto_3d
    const-string v3, "System"

    const-string v9, "******************************************"

    invoke-static {v3, v9}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 268
    const-string v3, "System"

    const-string v9, "************ Failure starting core service"

    move-object/from16 v0, v64

    invoke-static {v3, v9, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_b

    .line 200
    .end local v5           #battery:Lcom/android/server/BatteryService;
    .end local v7           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v64           #e:Ljava/lang/RuntimeException;
    .restart local v41       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v44       #battery:Lcom/android/server/BatteryService;
    .restart local v57       #cryptState:Ljava/lang/String;
    .restart local v67       #firstBoot:Z
    .restart local v86       #onlyCore:Z
    :cond_11
    const/4 v3, 0x0

    goto/16 :goto_7

    .line 230
    .end local v41           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v44           #battery:Lcom/android/server/BatteryService;
    .end local v71           #lights:Lcom/android/server/LightsService;
    .end local v107           #vibrator:Lcom/android/server/VibratorService;
    .restart local v5       #battery:Lcom/android/server/BatteryService;
    .restart local v7       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v72       #lights:Lcom/android/server/LightsService;
    .restart local v108       #vibrator:Lcom/android/server/VibratorService;
    :cond_12
    const/4 v3, 0x0

    move v9, v3

    goto/16 :goto_8

    :cond_13
    const/4 v3, 0x0

    goto/16 :goto_9

    .line 244
    :cond_14
    const/4 v3, 0x1

    move/from16 v0, v65

    if-ne v0, v3, :cond_15

    .line 245
    :try_start_50
    const-string v3, "SystemServer"

    const-string v9, "No Bluetooth Service (factory test)"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    goto/16 :goto_a

    .line 266
    :catch_2
    move-exception v64

    move-object/from16 v107, v108

    .end local v108           #vibrator:Lcom/android/server/VibratorService;
    .restart local v107       #vibrator:Lcom/android/server/VibratorService;
    move-object/from16 v71, v72

    .end local v72           #lights:Lcom/android/server/LightsService;
    .restart local v71       #lights:Lcom/android/server/LightsService;
    goto :goto_3d

    .line 247
    .end local v71           #lights:Lcom/android/server/LightsService;
    .end local v107           #vibrator:Lcom/android/server/VibratorService;
    .restart local v72       #lights:Lcom/android/server/LightsService;
    .restart local v108       #vibrator:Lcom/android/server/VibratorService;
    :cond_15
    const-string v3, "SystemServer"

    const-string v9, "Bluetooth Service"

    invoke-static {v3, v9}, Landroid/util/Slog;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 248
    new-instance v46, Landroid/server/BluetoothService;

    move-object/from16 v0, v46

    invoke-direct {v0, v4}, Landroid/server/BluetoothService;-><init>(Landroid/content/Context;)V
    :try_end_50
    .catch Ljava/lang/RuntimeException; {:try_start_50 .. :try_end_50} :catch_2

    .line 249
    .end local v45           #bluetooth:Landroid/server/BluetoothService;
    .local v46, bluetooth:Landroid/server/BluetoothService;
    :try_start_51
    const-string v3, "bluetooth"

    move-object/from16 v0, v46

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 250
    invoke-virtual/range {v46 .. v46}, Landroid/server/BluetoothService;->initAfterRegistration()V

    .line 252
    const-string v3, "0"

    const-string v9, "system_init.startaudioservice"

    invoke-static {v9}, Landroid/os/SystemProperties;->get(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v3, v9}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_16

    .line 253
    new-instance v48, Landroid/server/BluetoothA2dpService;

    move-object/from16 v0, v48

    move-object/from16 v1, v46

    invoke-direct {v0, v4, v1}, Landroid/server/BluetoothA2dpService;-><init>(Landroid/content/Context;Landroid/server/BluetoothService;)V
    :try_end_51
    .catch Ljava/lang/RuntimeException; {:try_start_51 .. :try_end_51} :catch_4d

    .line 254
    .end local v47           #bluetoothA2dp:Landroid/server/BluetoothA2dpService;
    .local v48, bluetoothA2dp:Landroid/server/BluetoothA2dpService;
    :try_start_52
    const-string v3, "bluetooth_a2dp"

    move-object/from16 v0, v48

    invoke-static {v3, v0}, Landroid/os/ServiceManager;->addService(Ljava/lang/String;Landroid/os/IBinder;)V

    .line 256
    invoke-virtual/range {v46 .. v46}, Landroid/server/BluetoothService;->initAfterA2dpRegistration()V
    :try_end_52
    .catch Ljava/lang/RuntimeException; {:try_start_52 .. :try_end_52} :catch_4e

    move-object/from16 v47, v48

    .line 259
    .end local v48           #bluetoothA2dp:Landroid/server/BluetoothA2dpService;
    .restart local v47       #bluetoothA2dp:Landroid/server/BluetoothA2dpService;
    :cond_16
    :try_start_53
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/android/server/ServerThread;->mContentResolver:Landroid/content/ContentResolver;

    const-string v9, "bluetooth_on"

    const/4 v10, 0x0

    invoke-static {v3, v9, v10}, Landroid/provider/Settings$Secure;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v49

    .line 261
    .local v49, bluetoothOn:I
    if-eqz v49, :cond_17

    .line 262
    invoke-virtual/range {v46 .. v46}, Landroid/server/BluetoothService;->enable()Z
    :try_end_53
    .catch Ljava/lang/RuntimeException; {:try_start_53 .. :try_end_53} :catch_4d

    :cond_17
    move-object/from16 v45, v46

    .end local v46           #bluetooth:Landroid/server/BluetoothService;
    .restart local v45       #bluetooth:Landroid/server/BluetoothService;
    goto/16 :goto_a

    .line 289
    .end local v49           #bluetoothOn:I
    .end local v57           #cryptState:Ljava/lang/String;
    .end local v67           #firstBoot:Z
    .end local v72           #lights:Lcom/android/server/LightsService;
    .end local v86           #onlyCore:Z
    .end local v108           #vibrator:Lcom/android/server/VibratorService;
    .restart local v42       #appWidget:Lcom/android/server/AppWidgetService;
    .restart local v55       #countryDetector:Lcom/android/server/CountryDetectorService;
    .restart local v58       #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .restart local v62       #dreamy:Landroid/service/dreams/DreamManagerService;
    .restart local v68       #imm:Lcom/android/server/InputMethodManagerService;
    .restart local v71       #lights:Lcom/android/server/LightsService;
    .restart local v73       #location:Lcom/android/server/LocationManagerService;
    .restart local v75       #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    .restart local v84       #notification:Lcom/android/server/NotificationManagerService;
    .restart local v97       #statusBar:Lcom/android/server/StatusBarManagerService;
    .restart local v101       #tsms:Lcom/android/server/TextServicesManagerService;
    .restart local v107       #vibrator:Lcom/android/server/VibratorService;
    .restart local v110       #wallpaper:Lcom/android/server/WallpaperManagerService;
    :catch_3
    move-exception v64

    .line 290
    .local v64, e:Ljava/lang/Throwable;
    :goto_3e
    const-string v3, "starting Input Manager Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_c

    .line 297
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_4
    move-exception v64

    .line 298
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "starting Accessibility Manager"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_d

    .line 304
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_5
    move-exception v64

    .line 305
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "making display ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_e

    .line 310
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_6
    move-exception v64

    .line 311
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "performing boot dexopt"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_f

    .line 333
    .end local v64           #e:Ljava/lang/Throwable;
    .restart local v78       #mountService:Lcom/android/server/MountService;
    :catch_7
    move-exception v64

    .line 334
    .restart local v64       #e:Ljava/lang/Throwable;
    :goto_3f
    const-string v3, "starting Mount Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_11

    .line 342
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_8
    move-exception v64

    .line 343
    .restart local v64       #e:Ljava/lang/Throwable;
    :goto_40
    const-string v3, "starting LockSettingsService service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_12

    .line 350
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_9
    move-exception v64

    .line 351
    .restart local v64       #e:Ljava/lang/Throwable;
    :goto_41
    const-string v3, "starting DevicePolicyService"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_13

    .line 358
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_a
    move-exception v64

    .line 359
    .restart local v64       #e:Ljava/lang/Throwable;
    :goto_42
    const-string v3, "starting StatusBarManagerService"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_14

    .line 366
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_b
    move-exception v64

    .line 367
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "starting Clipboard Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_15

    .line 374
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_c
    move-exception v64

    .line 375
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "starting NetworkManagement Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_16

    .line 382
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_d
    move-exception v64

    .line 383
    .restart local v64       #e:Ljava/lang/Throwable;
    :goto_43
    const-string v3, "starting Text Service Manager Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_17

    .line 390
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_e
    move-exception v64

    .line 391
    .restart local v64       #e:Ljava/lang/Throwable;
    :goto_44
    const-string v3, "starting NetworkStats Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_18

    .line 400
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_f
    move-exception v64

    move-object/from16 v8, v80

    .line 401
    .end local v80           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v8       #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v64       #e:Ljava/lang/Throwable;
    :goto_45
    const-string v3, "starting NetworkPolicy Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_19

    .line 408
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_10
    move-exception v64

    .line 409
    .restart local v64       #e:Ljava/lang/Throwable;
    :goto_46
    const-string v3, "starting Wi-Fi P2pService"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1a

    .line 416
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_11
    move-exception v64

    .line 417
    .restart local v64       #e:Ljava/lang/Throwable;
    :goto_47
    const-string v3, "starting Wi-Fi Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1b

    .line 429
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_12
    move-exception v64

    .line 430
    .restart local v64       #e:Ljava/lang/Throwable;
    :goto_48
    const-string v3, "starting Connectivity Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1c

    .line 438
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_13
    move-exception v64

    .line 439
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "starting Service Discovery Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1d

    .line 447
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_14
    move-exception v64

    .line 448
    .restart local v64       #e:Ljava/lang/Throwable;
    :goto_49
    const-string v3, "starting ThrottleService"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1e

    .line 455
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_15
    move-exception v64

    .line 456
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "starting UpdateLockService"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_1f

    .line 473
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_16
    move-exception v64

    .line 474
    .restart local v64       #e:Ljava/lang/Throwable;
    :goto_4a
    const-string v3, "starting Notification Manager"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_20

    .line 481
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_17
    move-exception v64

    .line 482
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "starting DeviceStorageMonitor service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_21

    .line 489
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_18
    move-exception v64

    .line 490
    .restart local v64       #e:Ljava/lang/Throwable;
    :goto_4b
    const-string v3, "starting Location Manager"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_22

    .line 497
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_19
    move-exception v64

    .line 498
    .restart local v64       #e:Ljava/lang/Throwable;
    :goto_4c
    const-string v3, "starting Country Detector"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_23

    .line 505
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_1a
    move-exception v64

    .line 506
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "starting Search Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_24

    .line 513
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_1b
    move-exception v64

    .line 514
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "starting DropBoxManagerService"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_25

    .line 525
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_1c
    move-exception v64

    .line 526
    .restart local v64       #e:Ljava/lang/Throwable;
    :goto_4d
    const-string v3, "starting Wallpaper Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_26

    .line 534
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_1d
    move-exception v64

    .line 535
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "starting Audio Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_27

    .line 543
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_1e
    move-exception v64

    .line 544
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "starting DockObserver"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_28

    .line 551
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_1f
    move-exception v64

    .line 552
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "starting WiredAccessoryObserver"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_29

    .line 560
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_20
    move-exception v64

    .line 561
    .restart local v64       #e:Ljava/lang/Throwable;
    :goto_4e
    const-string v3, "starting UsbService"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2a

    .line 569
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_21
    move-exception v64

    .line 570
    .restart local v64       #e:Ljava/lang/Throwable;
    :goto_4f
    const-string v3, "SystemServer"

    const-string v9, "Failure starting SerialService"

    move-object/from16 v0, v64

    invoke-static {v3, v9, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_2b

    .line 577
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_22
    move-exception v64

    .line 578
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "starting UiModeManagerService"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2c

    .line 585
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_23
    move-exception v64

    .line 586
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "SystemServer"

    const-string v9, "Failure starting Backup Service"

    move-object/from16 v0, v64

    invoke-static {v3, v9, v0}, Landroid/util/Slog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto/16 :goto_2d

    .line 593
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_24
    move-exception v64

    .line 594
    .restart local v64       #e:Ljava/lang/Throwable;
    :goto_50
    const-string v3, "starting AppWidget Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2e

    .line 600
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_25
    move-exception v64

    .line 601
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "starting Recognition Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_2f

    .line 607
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_26
    move-exception v64

    .line 608
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "starting DiskStats Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_30

    .line 619
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_27
    move-exception v64

    .line 620
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "starting SamplingProfiler Service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_31

    .line 626
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_28
    move-exception v64

    .line 627
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "starting NetworkTimeUpdate service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_32

    .line 634
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_29
    move-exception v64

    .line 635
    .restart local v64       #e:Ljava/lang/Throwable;
    :goto_51
    const-string v3, "starting CommonTimeManagementService service"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_33

    .line 641
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_2a
    move-exception v64

    .line 642
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "starting CertBlacklister"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_34

    .line 652
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_2b
    move-exception v64

    .line 653
    .restart local v64       #e:Ljava/lang/Throwable;
    :goto_52
    const-string v3, "starting DreamManagerService"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_35

    .line 669
    .end local v64           #e:Ljava/lang/Throwable;
    .end local v78           #mountService:Lcom/android/server/MountService;
    .restart local v28       #safeMode:Z
    :cond_18
    invoke-static {}, Ldalvik/system/VMRuntime;->getRuntime()Ldalvik/system/VMRuntime;

    move-result-object v3

    invoke-virtual {v3}, Ldalvik/system/VMRuntime;->startJitCompilation()V

    goto/16 :goto_36

    .line 676
    :catch_2c
    move-exception v64

    .line 677
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "making Vibrator Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_37

    .line 683
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_2d
    move-exception v64

    .line 684
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "making Device Policy Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_38

    .line 691
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_2e
    move-exception v64

    .line 692
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "making Notification Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_39

    .line 698
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_2f
    move-exception v64

    .line 699
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "making Window Manager Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_3a

    .line 718
    .end local v64           #e:Ljava/lang/Throwable;
    .restart local v52       #config:Landroid/content/res/Configuration;
    .restart local v77       #metrics:Landroid/util/DisplayMetrics;
    .restart local v109       #w:Landroid/view/WindowManager;
    :catch_30
    move-exception v64

    .line 719
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "making Package Manager Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_3b

    .line 723
    .end local v64           #e:Ljava/lang/Throwable;
    :catch_31
    move-exception v64

    .line 724
    .restart local v64       #e:Ljava/lang/Throwable;
    const-string v3, "making Lock Settings Service ready"

    move-object/from16 v0, p0

    move-object/from16 v1, v64

    invoke-virtual {v0, v3, v1}, Lcom/android/server/ServerThread;->reportWtf(Ljava/lang/String;Ljava/lang/Throwable;)V

    goto/16 :goto_3c

    .line 183
    .end local v5           #battery:Lcom/android/server/BatteryService;
    .end local v7           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v8           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .end local v28           #safeMode:Z
    .end local v42           #appWidget:Lcom/android/server/AppWidgetService;
    .end local v52           #config:Landroid/content/res/Configuration;
    .end local v55           #countryDetector:Lcom/android/server/CountryDetectorService;
    .end local v58           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .end local v62           #dreamy:Landroid/service/dreams/DreamManagerService;
    .end local v64           #e:Ljava/lang/Throwable;
    .end local v68           #imm:Lcom/android/server/InputMethodManagerService;
    .end local v73           #location:Lcom/android/server/LocationManagerService;
    .end local v75           #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    .end local v77           #metrics:Landroid/util/DisplayMetrics;
    .end local v84           #notification:Lcom/android/server/NotificationManagerService;
    .end local v97           #statusBar:Lcom/android/server/StatusBarManagerService;
    .end local v101           #tsms:Lcom/android/server/TextServicesManagerService;
    .end local v109           #w:Landroid/view/WindowManager;
    .end local v110           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .restart local v41       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v44       #battery:Lcom/android/server/BatteryService;
    .restart local v57       #cryptState:Ljava/lang/String;
    .restart local v67       #firstBoot:Z
    .restart local v80       #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v86       #onlyCore:Z
    :catch_32
    move-exception v3

    goto/16 :goto_5

    .line 652
    .end local v41           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v44           #battery:Lcom/android/server/BatteryService;
    .end local v57           #cryptState:Ljava/lang/String;
    .end local v67           #firstBoot:Z
    .end local v80           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .end local v86           #onlyCore:Z
    .restart local v5       #battery:Lcom/android/server/BatteryService;
    .restart local v7       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v8       #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v42       #appWidget:Lcom/android/server/AppWidgetService;
    .restart local v55       #countryDetector:Lcom/android/server/CountryDetectorService;
    .restart local v58       #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .restart local v63       #dreamy:Landroid/service/dreams/DreamManagerService;
    .restart local v68       #imm:Lcom/android/server/InputMethodManagerService;
    .restart local v73       #location:Lcom/android/server/LocationManagerService;
    .restart local v75       #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    .restart local v78       #mountService:Lcom/android/server/MountService;
    .restart local v84       #notification:Lcom/android/server/NotificationManagerService;
    .restart local v97       #statusBar:Lcom/android/server/StatusBarManagerService;
    .restart local v101       #tsms:Lcom/android/server/TextServicesManagerService;
    .restart local v110       #wallpaper:Lcom/android/server/WallpaperManagerService;
    :catch_33
    move-exception v64

    move-object/from16 v62, v63

    .end local v63           #dreamy:Landroid/service/dreams/DreamManagerService;
    .restart local v62       #dreamy:Landroid/service/dreams/DreamManagerService;
    goto :goto_52

    .line 634
    .end local v50           #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    .restart local v51       #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    :catch_34
    move-exception v64

    move-object/from16 v50, v51

    .end local v51           #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    .restart local v50       #commonTimeMgmtService:Lcom/android/server/CommonTimeManagementService;
    goto :goto_51

    .line 593
    .end local v42           #appWidget:Lcom/android/server/AppWidgetService;
    .restart local v43       #appWidget:Lcom/android/server/AppWidgetService;
    :catch_35
    move-exception v64

    move-object/from16 v42, v43

    .end local v43           #appWidget:Lcom/android/server/AppWidgetService;
    .restart local v42       #appWidget:Lcom/android/server/AppWidgetService;
    goto/16 :goto_50

    .line 569
    .end local v93           #serial:Lcom/android/server/SerialService;
    .restart local v94       #serial:Lcom/android/server/SerialService;
    :catch_36
    move-exception v64

    move-object/from16 v93, v94

    .end local v94           #serial:Lcom/android/server/SerialService;
    .restart local v93       #serial:Lcom/android/server/SerialService;
    goto/16 :goto_4f

    .line 560
    .end local v105           #usb:Lcom/android/server/usb/UsbService;
    .restart local v106       #usb:Lcom/android/server/usb/UsbService;
    :catch_37
    move-exception v64

    move-object/from16 v105, v106

    .end local v106           #usb:Lcom/android/server/usb/UsbService;
    .restart local v105       #usb:Lcom/android/server/usb/UsbService;
    goto/16 :goto_4e

    .line 525
    .end local v110           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .restart local v111       #wallpaper:Lcom/android/server/WallpaperManagerService;
    :catch_38
    move-exception v64

    move-object/from16 v110, v111

    .end local v111           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .restart local v110       #wallpaper:Lcom/android/server/WallpaperManagerService;
    goto/16 :goto_4d

    .line 497
    .end local v55           #countryDetector:Lcom/android/server/CountryDetectorService;
    .restart local v56       #countryDetector:Lcom/android/server/CountryDetectorService;
    :catch_39
    move-exception v64

    move-object/from16 v55, v56

    .end local v56           #countryDetector:Lcom/android/server/CountryDetectorService;
    .restart local v55       #countryDetector:Lcom/android/server/CountryDetectorService;
    goto/16 :goto_4c

    .line 489
    .end local v73           #location:Lcom/android/server/LocationManagerService;
    .restart local v74       #location:Lcom/android/server/LocationManagerService;
    :catch_3a
    move-exception v64

    move-object/from16 v73, v74

    .end local v74           #location:Lcom/android/server/LocationManagerService;
    .restart local v73       #location:Lcom/android/server/LocationManagerService;
    goto/16 :goto_4b

    .line 473
    .end local v84           #notification:Lcom/android/server/NotificationManagerService;
    .restart local v85       #notification:Lcom/android/server/NotificationManagerService;
    :catch_3b
    move-exception v64

    move-object/from16 v84, v85

    .end local v85           #notification:Lcom/android/server/NotificationManagerService;
    .restart local v84       #notification:Lcom/android/server/NotificationManagerService;
    goto/16 :goto_4a

    .line 447
    .end local v99           #throttle:Lcom/android/server/ThrottleService;
    .restart local v100       #throttle:Lcom/android/server/ThrottleService;
    :catch_3c
    move-exception v64

    move-object/from16 v99, v100

    .end local v100           #throttle:Lcom/android/server/ThrottleService;
    .restart local v99       #throttle:Lcom/android/server/ThrottleService;
    goto/16 :goto_49

    .line 429
    .end local v53           #connectivity:Lcom/android/server/ConnectivityService;
    .restart local v54       #connectivity:Lcom/android/server/ConnectivityService;
    :catch_3d
    move-exception v64

    move-object/from16 v53, v54

    .end local v54           #connectivity:Lcom/android/server/ConnectivityService;
    .restart local v53       #connectivity:Lcom/android/server/ConnectivityService;
    goto/16 :goto_48

    .line 416
    .end local v112           #wifi:Lcom/android/server/WifiService;
    .restart local v113       #wifi:Lcom/android/server/WifiService;
    :catch_3e
    move-exception v64

    move-object/from16 v112, v113

    .end local v113           #wifi:Lcom/android/server/WifiService;
    .restart local v112       #wifi:Lcom/android/server/WifiService;
    goto/16 :goto_47

    .line 408
    .end local v114           #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    .restart local v115       #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    :catch_3f
    move-exception v64

    move-object/from16 v114, v115

    .end local v115           #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    .restart local v114       #wifiP2p:Landroid/net/wifi/p2p/WifiP2pService;
    goto/16 :goto_46

    .line 400
    :catch_40
    move-exception v64

    goto/16 :goto_45

    .line 390
    .end local v8           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .end local v12           #networkStats:Lcom/android/server/net/NetworkStatsService;
    .restart local v80       #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v81       #networkStats:Lcom/android/server/net/NetworkStatsService;
    :catch_41
    move-exception v64

    move-object/from16 v12, v81

    .end local v81           #networkStats:Lcom/android/server/net/NetworkStatsService;
    .restart local v12       #networkStats:Lcom/android/server/net/NetworkStatsService;
    goto/16 :goto_44

    .line 382
    .end local v101           #tsms:Lcom/android/server/TextServicesManagerService;
    .restart local v102       #tsms:Lcom/android/server/TextServicesManagerService;
    :catch_42
    move-exception v64

    move-object/from16 v101, v102

    .end local v102           #tsms:Lcom/android/server/TextServicesManagerService;
    .restart local v101       #tsms:Lcom/android/server/TextServicesManagerService;
    goto/16 :goto_43

    .line 358
    .end local v97           #statusBar:Lcom/android/server/StatusBarManagerService;
    .restart local v98       #statusBar:Lcom/android/server/StatusBarManagerService;
    :catch_43
    move-exception v64

    move-object/from16 v97, v98

    .end local v98           #statusBar:Lcom/android/server/StatusBarManagerService;
    .restart local v97       #statusBar:Lcom/android/server/StatusBarManagerService;
    goto/16 :goto_42

    .line 350
    .end local v58           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .restart local v59       #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    :catch_44
    move-exception v64

    move-object/from16 v58, v59

    .end local v59           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .restart local v58       #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    goto/16 :goto_41

    .line 342
    .end local v75           #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    .restart local v76       #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    :catch_45
    move-exception v64

    move-object/from16 v75, v76

    .end local v76           #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    .restart local v75       #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    goto/16 :goto_40

    .line 333
    .end local v78           #mountService:Lcom/android/server/MountService;
    .restart local v79       #mountService:Lcom/android/server/MountService;
    :catch_46
    move-exception v64

    move-object/from16 v78, v79

    .end local v79           #mountService:Lcom/android/server/MountService;
    .restart local v78       #mountService:Lcom/android/server/MountService;
    goto/16 :goto_3f

    .line 319
    .end local v78           #mountService:Lcom/android/server/MountService;
    :catch_47
    move-exception v3

    goto/16 :goto_10

    .line 289
    .end local v68           #imm:Lcom/android/server/InputMethodManagerService;
    .restart local v69       #imm:Lcom/android/server/InputMethodManagerService;
    :catch_48
    move-exception v64

    move-object/from16 v68, v69

    .end local v69           #imm:Lcom/android/server/InputMethodManagerService;
    .restart local v68       #imm:Lcom/android/server/InputMethodManagerService;
    goto/16 :goto_3e

    .line 266
    .end local v5           #battery:Lcom/android/server/BatteryService;
    .end local v6           #power:Lcom/android/server/PowerManagerService;
    .end local v7           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v42           #appWidget:Lcom/android/server/AppWidgetService;
    .end local v55           #countryDetector:Lcom/android/server/CountryDetectorService;
    .end local v58           #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .end local v62           #dreamy:Landroid/service/dreams/DreamManagerService;
    .end local v68           #imm:Lcom/android/server/InputMethodManagerService;
    .end local v73           #location:Lcom/android/server/LocationManagerService;
    .end local v75           #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    .end local v84           #notification:Lcom/android/server/NotificationManagerService;
    .end local v97           #statusBar:Lcom/android/server/StatusBarManagerService;
    .end local v101           #tsms:Lcom/android/server/TextServicesManagerService;
    .end local v110           #wallpaper:Lcom/android/server/WallpaperManagerService;
    .restart local v41       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v44       #battery:Lcom/android/server/BatteryService;
    .restart local v88       #power:Lcom/android/server/PowerManagerService;
    :catch_49
    move-exception v64

    move-object/from16 v7, v41

    .end local v41           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v7       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v5, v44

    .end local v44           #battery:Lcom/android/server/BatteryService;
    .restart local v5       #battery:Lcom/android/server/BatteryService;
    move-object/from16 v6, v88

    .end local v88           #power:Lcom/android/server/PowerManagerService;
    .restart local v6       #power:Lcom/android/server/PowerManagerService;
    goto/16 :goto_3d

    .end local v5           #battery:Lcom/android/server/BatteryService;
    .end local v7           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v71           #lights:Lcom/android/server/LightsService;
    .restart local v41       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v44       #battery:Lcom/android/server/BatteryService;
    .restart local v57       #cryptState:Ljava/lang/String;
    .restart local v67       #firstBoot:Z
    .restart local v72       #lights:Lcom/android/server/LightsService;
    .restart local v86       #onlyCore:Z
    :catch_4a
    move-exception v64

    move-object/from16 v7, v41

    .end local v41           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v7       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v5, v44

    .end local v44           #battery:Lcom/android/server/BatteryService;
    .restart local v5       #battery:Lcom/android/server/BatteryService;
    move-object/from16 v71, v72

    .end local v72           #lights:Lcom/android/server/LightsService;
    .restart local v71       #lights:Lcom/android/server/LightsService;
    goto/16 :goto_3d

    .end local v7           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v71           #lights:Lcom/android/server/LightsService;
    .restart local v41       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v72       #lights:Lcom/android/server/LightsService;
    :catch_4b
    move-exception v64

    move-object/from16 v7, v41

    .end local v41           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v7       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v71, v72

    .end local v72           #lights:Lcom/android/server/LightsService;
    .restart local v71       #lights:Lcom/android/server/LightsService;
    goto/16 :goto_3d

    .end local v7           #alarm:Lcom/android/server/AlarmManagerService;
    .end local v71           #lights:Lcom/android/server/LightsService;
    .end local v107           #vibrator:Lcom/android/server/VibratorService;
    .restart local v41       #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v72       #lights:Lcom/android/server/LightsService;
    .restart local v108       #vibrator:Lcom/android/server/VibratorService;
    :catch_4c
    move-exception v64

    move-object/from16 v7, v41

    .end local v41           #alarm:Lcom/android/server/AlarmManagerService;
    .restart local v7       #alarm:Lcom/android/server/AlarmManagerService;
    move-object/from16 v107, v108

    .end local v108           #vibrator:Lcom/android/server/VibratorService;
    .restart local v107       #vibrator:Lcom/android/server/VibratorService;
    move-object/from16 v71, v72

    .end local v72           #lights:Lcom/android/server/LightsService;
    .restart local v71       #lights:Lcom/android/server/LightsService;
    goto/16 :goto_3d

    .end local v45           #bluetooth:Landroid/server/BluetoothService;
    .end local v71           #lights:Lcom/android/server/LightsService;
    .end local v107           #vibrator:Lcom/android/server/VibratorService;
    .restart local v46       #bluetooth:Landroid/server/BluetoothService;
    .restart local v72       #lights:Lcom/android/server/LightsService;
    .restart local v108       #vibrator:Lcom/android/server/VibratorService;
    :catch_4d
    move-exception v64

    move-object/from16 v45, v46

    .end local v46           #bluetooth:Landroid/server/BluetoothService;
    .restart local v45       #bluetooth:Landroid/server/BluetoothService;
    move-object/from16 v107, v108

    .end local v108           #vibrator:Lcom/android/server/VibratorService;
    .restart local v107       #vibrator:Lcom/android/server/VibratorService;
    move-object/from16 v71, v72

    .end local v72           #lights:Lcom/android/server/LightsService;
    .restart local v71       #lights:Lcom/android/server/LightsService;
    goto/16 :goto_3d

    .end local v45           #bluetooth:Landroid/server/BluetoothService;
    .end local v47           #bluetoothA2dp:Landroid/server/BluetoothA2dpService;
    .end local v71           #lights:Lcom/android/server/LightsService;
    .end local v107           #vibrator:Lcom/android/server/VibratorService;
    .restart local v46       #bluetooth:Landroid/server/BluetoothService;
    .restart local v48       #bluetoothA2dp:Landroid/server/BluetoothA2dpService;
    .restart local v72       #lights:Lcom/android/server/LightsService;
    .restart local v108       #vibrator:Lcom/android/server/VibratorService;
    :catch_4e
    move-exception v64

    move-object/from16 v47, v48

    .end local v48           #bluetoothA2dp:Landroid/server/BluetoothA2dpService;
    .restart local v47       #bluetoothA2dp:Landroid/server/BluetoothA2dpService;
    move-object/from16 v45, v46

    .end local v46           #bluetooth:Landroid/server/BluetoothService;
    .restart local v45       #bluetooth:Landroid/server/BluetoothService;
    move-object/from16 v107, v108

    .end local v108           #vibrator:Lcom/android/server/VibratorService;
    .restart local v107       #vibrator:Lcom/android/server/VibratorService;
    move-object/from16 v71, v72

    .end local v72           #lights:Lcom/android/server/LightsService;
    .restart local v71       #lights:Lcom/android/server/LightsService;
    goto/16 :goto_3d

    .end local v57           #cryptState:Ljava/lang/String;
    .end local v67           #firstBoot:Z
    .end local v86           #onlyCore:Z
    .restart local v42       #appWidget:Lcom/android/server/AppWidgetService;
    .restart local v55       #countryDetector:Lcom/android/server/CountryDetectorService;
    .restart local v58       #devicePolicy:Lcom/android/server/DevicePolicyManagerService;
    .restart local v62       #dreamy:Landroid/service/dreams/DreamManagerService;
    .restart local v68       #imm:Lcom/android/server/InputMethodManagerService;
    .restart local v73       #location:Lcom/android/server/LocationManagerService;
    .restart local v75       #lockSettings:Lcom/android/internal/widget/LockSettingsService;
    .restart local v84       #notification:Lcom/android/server/NotificationManagerService;
    .restart local v97       #statusBar:Lcom/android/server/StatusBarManagerService;
    .restart local v101       #tsms:Lcom/android/server/TextServicesManagerService;
    .restart local v110       #wallpaper:Lcom/android/server/WallpaperManagerService;
    :cond_19
    move-object/from16 v8, v80

    .end local v80           #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    .restart local v8       #networkPolicy:Lcom/android/server/net/NetworkPolicyManagerService;
    goto/16 :goto_35
.end method
