package xiaozhi.modules.agent.entity;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@TableName("ai_agent")
@Schema(description = "Agent Information")
public class AgentEntity {

    @TableId(type = IdType.ASSIGN_UUID)
    @Schema(description = "Agent Unique Identifier")
    private String id;

    @Schema(description = "Owner User ID")
    private Long userId;

    @Schema(description = "Agent Code")
    private String agentCode;

    @Schema(description = "Agent Name")
    private String agentName;

    @Schema(description = "Speech Recognition Model ID")
    private String asrModelId;

    @Schema(description = "Voice Activity Detection ID")
    private String vadModelId;

    @Schema(description = "Large Language Model ID")
    private String llmModelId;

    @Schema(description = "Vision Language Model ID")
    private String vllmModelId;

    @Schema(description = "Text-to-Speech Model ID")
    private String ttsModelId;

    @Schema(description = "Voice Timbre ID")
    private String ttsVoiceId;

    @Schema(description = "Memory Model ID")
    private String memModelId;

    @Schema(description = "Intent Model ID")
    private String intentModelId;

    @Schema(description = "Chat History Configuration (0: No Recording, 1: Text Only, 2: Text and Voice)")
    private Integer chatHistoryConf;

    @Schema(description = "Role Configuration Parameters")
    private String systemPrompt;

    @Schema(description = "Summary Memory", example = "Build a dynamic memory network that can grow, intelligently maintain information evolution trajectory while retaining key information in limited space\n" +
            "Based on conversation records, summarize important user information to provide more personalized service in future conversations", required = false)
    private String summaryMemory;

    @Schema(description = "Language Code")
    private String langCode;

    @Schema(description = "Interaction Language")
    private String language;

    @Schema(description = "Sort Order")
    private Integer sort;

    @Schema(description = "Creator")
    private Long creator;

    @Schema(description = "Creation Time")
    private Date createdAt;

    @Schema(description = "Updater")
    private Long updater;

    @Schema(description = "Update Time")
    private Date updatedAt;
}