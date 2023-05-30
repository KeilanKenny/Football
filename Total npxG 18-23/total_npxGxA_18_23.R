library(rvest)

# 22/23
npxgxa_22_23_data <- read_html("https://fbref.com/en/comps/Big5/stats/players/Big-5-European-Leagues-Stats")

player_22_23 = html_nodes(npxgxa_22_23_data, 'th.right+ .left')
player_22_23 = html_text(player_22_23)
player_22_23 <- as.factor(player_22_23)

npxgxa_22_23 = html_nodes(npxgxa_22_23_data, '.right:nth-child(24)')
npxgxa_22_23 = html_text(npxgxa_22_23)
npxgxa_22_23 <- as.numeric(npxgxa_22_23)


data_22_23 <- data.frame(Player = player_22_23,npxGxA_22_23 = npxgxa_22_23)


# 21/22
npxgxa_21_22_data <- read_html("https://fbref.com/en/comps/Big5/2021-2022/stats/players/2021-2022-Big-5-European-Leagues-Stats")

player_21_22 = html_nodes(npxgxa_21_22_data, 'th.right+ .left')
player_21_22 = html_text(player_21_22)
player_21_22 <- as.factor(player_21_22)

npxgxa_21_22 = html_nodes(npxgxa_21_22_data, '.right:nth-child(24)')
npxgxa_21_22 = html_text(npxgxa_21_22)
npxgxa_21_22 <- as.numeric(npxgxa_21_22)


data_21_22 <- data.frame(Player = player_21_22,npxGxA_21_22 = npxgxa_21_22 )

# 20/21
npxgxa_20_21_data <- read_html("https://fbref.com/en/comps/Big5/2020-2021/stats/players/2020-2021-Big-5-European-Leagues-Stats")

player_20_21 = html_nodes(npxgxa_20_21_data, 'th.right+ .left')
player_20_21 = html_text(player_20_21)
player_20_21 <- as.factor(player_20_21)

npxgxa_20_21 = html_nodes(npxgxa_20_21_data, '.right:nth-child(24)')
npxgxa_20_21 = html_text(npxgxa_20_21)
npxgxa_20_21 <- as.numeric(npxgxa_20_21)


data_20_21 <- data.frame(Player = player_20_21,npxGxA_20_21 = npxgxa_20_21 )

# 19/20
npxgxa_19_20_data <- read_html("https://fbref.com/en/comps/Big5/2019-2020/stats/players/2019-2020-Big-5-European-Leagues-Stats")

player_19_20 = html_nodes(npxgxa_19_20_data, 'th.right+ .left')
player_19_20 = html_text(player_19_20)
player_19_20 <- as.factor(player_19_20)

npxgxa_19_20 = html_nodes(npxgxa_19_20_data, '.right:nth-child(24)')
npxgxa_19_20 = html_text(npxgxa_19_20)
npxgxa_19_20 <- as.numeric(npxgxa_19_20)


data_19_20 <- data.frame(Player = player_19_20,npxGxA_19_20 = npxgxa_19_20 )


# 18/19
npxgxa_18_19_data <- read_html("https://fbref.com/en/comps/Big5/2018-2019/stats/players/2018-2019-Big-5-European-Leagues-Stats")

player_18_19 = html_nodes(npxgxa_18_19_data, 'th.right+ .left')
player_18_19 = html_text(player_18_19)
player_18_19 <- as.factor(player_18_19)

npxgxa_18_19 = html_nodes(npxgxa_18_19_data, '.right:nth-child(24)')
npxgxa_18_19 = html_text(npxgxa_18_19)
npxgxa_18_19 <- as.numeric(npxgxa_18_19)


data_18_19 <- data.frame(Player = player_18_19,npxGxA_18_19 = npxgxa_18_19 )



data <- merge(data_21_22, data_22_23, by = 'Player')
data <- merge(data_20_21,data, by = 'Player')
data <- merge(data_19_20,data, by = 'Player')
data <- merge(data_18_19,data, by = 'Player')
data$total_npxGxA <- as.numeric(apply(data[,2:6], 1, sum))

data_ordered <- data[order(data$total_npxGxA, decreasing = TRUE), ] 
final_data <- data_ordered[!duplicated(data_ordered$Player), ]


















plot_data <- head(final_data,25)
plot_data <- plot_data[order(plot_data$total_npxGxA, decreasing = FALSE), ]
plot_data <- as.data.frame(t(plot_data))
names(plot_data) <- plot_data[1,]
plot_data <- plot_data[-1,]
plot_data <- plot_data[1:5,]

par(mar = c(5, 10, 5, 7.5))
x <-barplot(as.matrix(plot_data),
            main = "TOTAL NPXG + XA SINCE 2018/19.",
            xlab = "npxG + xA",
            axes = TRUE,
            horiz = TRUE,
            col = c("#F8B195", "#F67280", "#C06C84", "#6C5B7B", "#355C7D"),
            border = NA,
            legend.text = c("18/19", "19/20", "20/21", "21/22", "22/23"),
            args.legend = list(cex= .7,x = "bottomright",inset = c(-0,0.1)), 
            cex.names=.9,
            las=1,
            xaxp=c(0, 170, 17))
title('Top 5 leagues | Data: FBref | @kennykeilan',line=-0.00,font.main = 1)