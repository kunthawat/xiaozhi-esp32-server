package xiaozhi.modules.device.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
@TableName("ai_device")
@Schema(description = "Device Information")
public class DeviceEntity {

    @TableId(type = IdType.ASSIGN_UUID)
    @Schema(description = "ID")
    private String id;

    @Schema(description = "Associated User ID")
    private Long userId;

    @Schema(description = "MAC Address")
    private String macAddress;

    @Schema(description = "Last Connection Time")
    private Date lastConnectedAt;

    @Schema(description = "Auto Update Switch (0=Off/1=On)")
    private Integer autoUpdate;

    @Schema(description = "Device Hardware Model")
    private String board;

    @Schema(description = "Device Alias")
    private String alias;

    @Schema(description = "Agent ID")
    private String agentId;

    @Schema(description = "Firmware Version Number")
    private String appVersion;

    @Schema(description = "Sort Order")
    private Integer sort;

    @Schema(description = "Updater")
    @TableField(fill = FieldFill.UPDATE)
    private Long updater;

    @Schema(description = "Update Time")
    @TableField(fill = FieldFill.UPDATE)
    private Date updateDate;

    @Schema(description = "Creator")
    @TableField(fill = FieldFill.INSERT)
    private Long creator;

    @Schema(description = "Create Time")
    @TableField(fill = FieldFill.INSERT)
    private Date createDate;
}