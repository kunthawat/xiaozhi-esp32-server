package xiaozhi.modules.device.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "User Display Device List VO")
public class UserShowDeviceListVO {

    @Schema(description = "App Version")
    private String appVersion;

    @Schema(description = "Bound User Name")
    private String bindUserName;

    @Schema(description = "Device Model")
    private String deviceType;

    @Schema(description = "Device Unique Identifier")
    private String id;

    @Schema(description = "MAC Address")
    private String macAddress;

    @Schema(description = "Enable OTA")
    private Integer otaUpgrade;

    @Schema(description = "Recent Chat Time")
    private String recentChatTime;

}