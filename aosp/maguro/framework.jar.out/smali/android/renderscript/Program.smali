.class public Landroid/renderscript/Program;
.super Landroid/renderscript/BaseObj;
.source "Program.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/renderscript/Program$BaseProgramBuilder;,
        Landroid/renderscript/Program$ProgramParam;,
        Landroid/renderscript/Program$TextureType;
    }
.end annotation


# static fields
.field static final MAX_CONSTANT:I = 0x8

.field static final MAX_INPUT:I = 0x8

.field static final MAX_OUTPUT:I = 0x8

.field static final MAX_TEXTURE:I = 0x8


# instance fields
.field mConstants:[Landroid/renderscript/Type;

.field mInputs:[Landroid/renderscript/Element;

.field mOutputs:[Landroid/renderscript/Element;

.field mShader:Ljava/lang/String;

.field mTextureCount:I

.field mTextureNames:[Ljava/lang/String;

.field mTextures:[Landroid/renderscript/Program$TextureType;


# direct methods
.method constructor <init>(ILandroid/renderscript/RenderScript;)V
    .locals 0
    .parameter "id"
    .parameter "rs"

    .prologue
    .line 77
    invoke-direct {p0, p1, p2}, Landroid/renderscript/BaseObj;-><init>(ILandroid/renderscript/RenderScript;)V

    .line 78
    return-void
.end method


# virtual methods
.method public bindConstants(Landroid/renderscript/Allocation;I)V
    .locals 4
    .parameter "a"
    .parameter "slot"

    .prologue
    .line 145
    if-ltz p2, :cond_0

    iget-object v1, p0, Landroid/renderscript/Program;->mConstants:[Landroid/renderscript/Type;

    array-length v1, v1

    if-lt p2, v1, :cond_1

    .line 146
    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Slot ID out of range."

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 148
    :cond_1
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Landroid/renderscript/Allocation;->getType()Landroid/renderscript/Type;

    move-result-object v1

    iget-object v2, p0, Landroid/renderscript/Program;->mRS:Landroid/renderscript/RenderScript;

    invoke-virtual {v1, v2}, Landroid/renderscript/Type;->getID(Landroid/renderscript/RenderScript;)I

    move-result v1

    iget-object v2, p0, Landroid/renderscript/Program;->mConstants:[Landroid/renderscript/Type;

    aget-object v2, v2, p2

    iget-object v3, p0, Landroid/renderscript/Program;->mRS:Landroid/renderscript/RenderScript;

    invoke-virtual {v2, v3}, Landroid/renderscript/Type;->getID(Landroid/renderscript/RenderScript;)I

    move-result v2

    if-eq v1, v2, :cond_2

    .line 150
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Allocation type does not match slot type."

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 152
    :cond_2
    if-eqz p1, :cond_3

    iget-object v1, p0, Landroid/renderscript/Program;->mRS:Landroid/renderscript/RenderScript;

    invoke-virtual {p1, v1}, Landroid/renderscript/Allocation;->getID(Landroid/renderscript/RenderScript;)I

    move-result v0

    .line 153
    .local v0, id:I
    :goto_0
    iget-object v1, p0, Landroid/renderscript/Program;->mRS:Landroid/renderscript/RenderScript;

    iget-object v2, p0, Landroid/renderscript/Program;->mRS:Landroid/renderscript/RenderScript;

    invoke-virtual {p0, v2}, Landroid/renderscript/Program;->getID(Landroid/renderscript/RenderScript;)I

    move-result v2

    invoke-virtual {v1, v2, p2, v0}, Landroid/renderscript/RenderScript;->nProgramBindConstants(III)V

    .line 154
    return-void

    .line 152
    .end local v0           #id:I
    :cond_3
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public bindSampler(Landroid/renderscript/Sampler;I)V
    .locals 3
    .parameter "vs"
    .parameter "slot"
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .prologue
    .line 189
    iget-object v1, p0, Landroid/renderscript/Program;->mRS:Landroid/renderscript/RenderScript;

    invoke-virtual {v1}, Landroid/renderscript/RenderScript;->validate()V

    .line 190
    if-ltz p2, :cond_0

    iget v1, p0, Landroid/renderscript/Program;->mTextureCount:I

    if-lt p2, v1, :cond_1

    .line 191
    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Slot ID out of range."

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 194
    :cond_1
    if-eqz p1, :cond_2

    iget-object v1, p0, Landroid/renderscript/Program;->mRS:Landroid/renderscript/RenderScript;

    invoke-virtual {p1, v1}, Landroid/renderscript/Sampler;->getID(Landroid/renderscript/RenderScript;)I

    move-result v0

    .line 195
    .local v0, id:I
    :goto_0
    iget-object v1, p0, Landroid/renderscript/Program;->mRS:Landroid/renderscript/RenderScript;

    iget-object v2, p0, Landroid/renderscript/Program;->mRS:Landroid/renderscript/RenderScript;

    invoke-virtual {p0, v2}, Landroid/renderscript/Program;->getID(Landroid/renderscript/RenderScript;)I

    move-result v2

    invoke-virtual {v1, v2, p2, v0}, Landroid/renderscript/RenderScript;->nProgramBindSampler(III)V

    .line 196
    return-void

    .line 194
    .end local v0           #id:I
    :cond_2
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public bindTexture(Landroid/renderscript/Allocation;I)V
    .locals 3
    .parameter "va"
    .parameter "slot"
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .prologue
    .line 165
    iget-object v1, p0, Landroid/renderscript/Program;->mRS:Landroid/renderscript/RenderScript;

    invoke-virtual {v1}, Landroid/renderscript/RenderScript;->validate()V

    .line 166
    if-ltz p2, :cond_0

    iget v1, p0, Landroid/renderscript/Program;->mTextureCount:I

    if-lt p2, v1, :cond_1

    .line 167
    :cond_0
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Slot ID out of range."

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 169
    :cond_1
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Landroid/renderscript/Allocation;->getType()Landroid/renderscript/Type;

    move-result-object v1

    invoke-virtual {v1}, Landroid/renderscript/Type;->hasFaces()Z

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Landroid/renderscript/Program;->mTextures:[Landroid/renderscript/Program$TextureType;

    aget-object v1, v1, p2

    sget-object v2, Landroid/renderscript/Program$TextureType;->TEXTURE_CUBE:Landroid/renderscript/Program$TextureType;

    if-eq v1, v2, :cond_2

    .line 171
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "Cannot bind cubemap to 2d texture slot"

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 174
    :cond_2
    if-eqz p1, :cond_3

    iget-object v1, p0, Landroid/renderscript/Program;->mRS:Landroid/renderscript/RenderScript;

    invoke-virtual {p1, v1}, Landroid/renderscript/Allocation;->getID(Landroid/renderscript/RenderScript;)I

    move-result v0

    .line 175
    .local v0, id:I
    :goto_0
    iget-object v1, p0, Landroid/renderscript/Program;->mRS:Landroid/renderscript/RenderScript;

    iget-object v2, p0, Landroid/renderscript/Program;->mRS:Landroid/renderscript/RenderScript;

    invoke-virtual {p0, v2}, Landroid/renderscript/Program;->getID(Landroid/renderscript/RenderScript;)I

    move-result v2

    invoke-virtual {v1, v2, p2, v0}, Landroid/renderscript/RenderScript;->nProgramBindTexture(III)V

    .line 176
    return-void

    .line 174
    .end local v0           #id:I
    :cond_3
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getConstant(I)Landroid/renderscript/Type;
    .locals 2
    .parameter "slot"

    .prologue
    .line 97
    if-ltz p1, :cond_0

    iget-object v0, p0, Landroid/renderscript/Program;->mConstants:[Landroid/renderscript/Type;

    array-length v0, v0

    if-lt p1, v0, :cond_1

    .line 98
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Slot ID out of range."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 100
    :cond_1
    iget-object v0, p0, Landroid/renderscript/Program;->mConstants:[Landroid/renderscript/Type;

    aget-object v0, v0, p1

    return-object v0
.end method

.method public getConstantCount()I
    .locals 1

    .prologue
    .line 86
    iget-object v0, p0, Landroid/renderscript/Program;->mConstants:[Landroid/renderscript/Type;

    if-eqz v0, :cond_0

    iget-object v0, p0, Landroid/renderscript/Program;->mConstants:[Landroid/renderscript/Type;

    array-length v0, v0

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getTextureCount()I
    .locals 1

    .prologue
    .line 108
    iget v0, p0, Landroid/renderscript/Program;->mTextureCount:I

    return v0
.end method

.method public getTextureName(I)Ljava/lang/String;
    .locals 2
    .parameter "slot"

    .prologue
    .line 130
    if-ltz p1, :cond_0

    iget v0, p0, Landroid/renderscript/Program;->mTextureCount:I

    if-lt p1, v0, :cond_1

    .line 131
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Slot ID out of range."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 133
    :cond_1
    iget-object v0, p0, Landroid/renderscript/Program;->mTextureNames:[Ljava/lang/String;

    aget-object v0, v0, p1

    return-object v0
.end method

.method public getTextureType(I)Landroid/renderscript/Program$TextureType;
    .locals 2
    .parameter "slot"

    .prologue
    .line 117
    if-ltz p1, :cond_0

    iget v0, p0, Landroid/renderscript/Program;->mTextureCount:I

    if-lt p1, v0, :cond_1

    .line 118
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Slot ID out of range."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 120
    :cond_1
    iget-object v0, p0, Landroid/renderscript/Program;->mTextures:[Landroid/renderscript/Program$TextureType;

    aget-object v0, v0, p1

    return-object v0
.end method
