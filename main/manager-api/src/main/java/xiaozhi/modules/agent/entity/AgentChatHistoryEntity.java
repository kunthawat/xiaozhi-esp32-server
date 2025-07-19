package xiaozhi.modules.agent.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Agent Chat History Table
 *
 * @author Goody
 * @version 1.0, 2025/4/30
 * @since 1.0.0
 */
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "ai_agent_chat_history")
public class AgentChatHistoryEntity {
    /**
     * Primary Key ID
     */
    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * MAC Address
     */
    @TableField(value = "mac_address")
    private String macAddress;

    /**
     * Agent ID
     */
    @TableField(value = "agent_id")
    private String agentId;

    /**
     * Session ID
     */
    @TableField(value = "session_id")
    private String sessionId;

    /**
     * Message Type: 1-User, 2-Agent
     */
    @TableField(value = "chat_type")
    private Byte chatType;

    /**
     * Chat Content
     */
    @TableField(value = "content")
    private String content;

    /**
     * Audio Base64 Data
     */
    @TableField(value = "audio_id")
    private String audioId;

    /**
     * Creation Time
     */
    @TableField(value = "created_at")
    private Date createdAt;

    /**
     * Update Time
     */
    @TableField(value = "updated_at")
    private Date updatedAt;
}
