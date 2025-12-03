# Android 端节点列表无法加载问题分析

## 问题现象
1. Windows 端正常，Android 端显示"未找到节点"
2. `setupConfig` 在 Android 端超时（30秒+）
3. `getProxies` 调用后长时间无响应（15秒+）
4. 日志显示：`CoreHandlerInterface: getProxies returned: null items`

## 根本原因
Android 端的 Clash Core 在处理配置时卡住，导致：
- `setupConfig` 超时
- `getProxies` 返回 null 或超时

## 可能的原因
1. **配置文件问题**：某些字段在 Android 端无法正确解析
2. **Core 版本差异**：Android 和 Windows 使用不同版本的 Clash Core
3. **JNI 调用问题**：Android 端的 Native 调用存在死锁或阻塞
4. **内存/性能问题**：Android 设备资源不足

## 已尝试的解决方案
1. ✅ 增加详细日志输出
2. ✅ 延长超时时间（10s → 30s）
3. ✅ 添加重试机制（3次）
4. ✅ Android 端添加额外等待时间（2-5秒）
5. ⏳ 简化配置文件测试

## 下一步行动
1. 检查配置文件中的特殊字段（如 proxy-providers）
2. 对比 Windows 和 Android 生成的 config.json
3. 检查 Android 端 Clash Core 的日志输出
4. 尝试最小化配置文件进行测试
