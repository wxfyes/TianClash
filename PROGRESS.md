# Dashboard Refactoring Progress

**Date:** 2025-12-02
**Status:** Phase 4 Complete (Assembly Done)

## Completed Work

### 1. Navigation & Structure
- [x] **Navigation**: Updated `lib/common/navigation.dart`.
    - Hidden "Proxies" tab.
    - Renamed "Shop" to "Plans".
    - Moved secondary items to "More".

### 2. New Core Components
- [x] **Proxy Selector** (`lib/views/dashboard/widgets/proxy_selector.dart`)
    - Implemented dropdown with node list.
    - Auto-delay testing on expand.
    - Shows current node and delay status.
    - Handles "Global" vs "Rule" mode logic for group selection.

- [x] **Mode Switcher** (`lib/views/dashboard/widgets/mode_switcher.dart`)
    - Simplified to "Rule" (智能) and "Global" (全局).
    - Uses `SegmentedButton` for modern UI.

- [x] **Central Connection Button** (`lib/views/dashboard/widgets/central_connection_button.dart`)
    - Large circular button (120dp).
    - Visual states for Disconnected, Connecting, Connected.
    - Animated transitions.

## Pending Tasks (Next Session)

### Phase 3: Existing Component Adjustments
- [x] **UserInfoCard** (`lib/views/dashboard/widgets/user_info_card.dart`)
    -   Simplify layout: Remove traffic bar.
    -   Compact height.
- [x] **NetworkDetection** (`lib/views/dashboard/widgets/network_detection.dart`)
    -   Simplify to single line (Flag + IP).
- [x] **IntranetIP** (`lib/views/dashboard/widgets/intranet_ip.dart`)
    -   Simplify to single line.

### Phase 4: Assembly (Crucial)
- [x] **Refactor `lib/views/dashboard/dashboard.dart`**:
    -   Removed `SuperGrid` and `DashboardWidget` enum usage.
    -   Implemented a simple `SingleChildScrollView` + `Column` layout.
    -   **Order**:
        1.  UserInfoCard
        2.  ProxySelector
        3.  NetworkDetection
        4.  CentralConnectionButton (Center)
        5.  ModeSwitcher
        6.  IntranetIP

## Notes for Developer
-   **Uncommitted Changes**: `lib/views/dashboard/widgets/mode_switcher.dart` is modified but not committed.
-   **Integration Point**: The new widgets are ready but not yet imported/used in `dashboard.dart`. The app will still look like the old version until `dashboard.dart` is updated.
