%% Plot Fig 4B-G from Dewey and Shera (2023) JARO
close all;clear;clc;
load Dewey_2023_JARO_figs.mat

panels = [{'b'};{'c'};{'d'};{'e'};{'f'};{'g'}]; % panel letters
panelN = length(panels);

% Plot each panel
for p_i = 1:panelN
    panel = panels{p_i};

    switch panel
        case 'b'
            %% Fig. 4B - Individual BM data from middle turn

            f1s = fig4.b.BM.f1s; % stimulus frequency (Hz)
            L1s = fig4.b.BM.L1s; % stimulus level (dB SPL)
            L1N = length(L1s);
            mag = fig4.b.BM.vib.f1.mag; % displacement magnitude (nm RMS)
            magC = fig4.b.BM.vib.f1.magC; % clean displacement magnitude
           
            clr = [28 82 172]/255; % color
            
            % Set up figure
            h=figure('units','normalized','position',[.1 .2 .165 .42]);
            ax1 = axes('position',[.18 .42 .7 .42], 'box', 'off','LineWidth',1.4, 'FontSize',15); hold on;
            axes(ax1);
            xlim([2.5 30]); set(gca,'Xscale','log','Xtick',[1 2 5 10 20 50]);
            ax1.XAxis.TickLength = [0.02 0.02];
            
            ylim([-30 30]); set(gca,'Ytick',-100:20:100);
            ax1.YAxis.MinorTick = 'on';
            ax1.YAxis.MinorTickValues = -100:10:100;
            ax1.YAxis.TickLength = [0.02 0.02];
            
            % Plot displacement (dB re 1) vs. stimulus level
            for L_i=L1N:-1:1                
                lw = 0.35+L_i*0.35; % line width

                axes(ax1); 
                if L1s(L_i)==60 % Plot dotted line for data not meeting signal-to-noise criterion
                    plot(f1s(f1s<20000 & f1s > 5000)/1000, 20*log10(mag(f1s<20000 & f1s > 5000,L_i)), ':','LineWidth',1.8, 'Color', clr);
                end

                plot(f1s/1000, 20*log10(magC(:,L_i)), '-', 'LineWidth',lw, 'Color', clr);
            end


        case 'c'
            %% Fig. 4C - Apical and middle-turn BM response re stimulus pressure
            regions =[{'apical'};{'mid'}]; % cochlear regions
            clrs = [{[66 163 220]/255};{[28 82 172]/255}]; % plot colors

            % Set up figure
            h=figure('units','normalized','position',[.25 .2 .22 .42]);
            ax1 = axes('position',[.18 .42 .7 .5], 'box', 'off','LineWidth',1.4, 'FontSize',15); hold on;
            ax2 = axes('position',[.18 .16 .7 .23], 'box', 'off','LineWidth', 1.4, 'FontSize', 15); hold on;
            
            axes(ax1); % Displacement normalized to stimulus pressure (dB re 1 nm/Pa)
            xlim([.95 25]); set(gca,'Xscale','log','Xtick',[1 2 5 10 20 50]);
            ax1.XAxis.TickLength = [0.015 0.015];
            ax1.XAxis.Visible = 'off';
            ylim([-5 67.5]); set(gca,'Ytick',-100:20:100);
            ax1.YAxis.MinorTick = 'on';
            ax1.YAxis.MinorTickValues = -100:10:100;
            ax1.YAxis.TickLength = [0.015 0.015];
            
            axes(ax2); % Displacement phase (cycles)
            xlim([.95 25]); set(gca,'Xscale','log','Xtick',[1 2 5 10 20 50]);
            ylim([-6 0]); set(gca,'Ytick',-10:2:10);
            ax2.YAxis.MinorTick = 'on';
            ax2.YAxis.MinorTickValues = -10:1:10;
            ax2.XAxis.TickLength = [0.015 0.015];
            ax2.YAxis.TickLength = [0.015 0.015];
            
            % Plot data for each cochlear region
            for r_i = 1:length(regions)
                region = regions{r_i}; % region 
                clr = clrs{r_i}; % color
                
                f1s = fig4.c.(genvarname(region)).BM.f1s; % stimulus frequency (Hz)
                L1s = fig4.c.(genvarname(region)).BM.L1s; % stimulus level (dB SPL)
                L1N = length(L1s); % # levels
                gainC = fig4.c.(genvarname(region)).BM.vib.f1.gainC; % clean displacement 'gain' re stimulus pressure
                phiC = fig4.c.(genvarname(region)).BM.vib.f1.phiC; % clean displacement phase

                % Plot data for each level
                for L_i=L1N:-1:1
                    lw = 0.7+L_i*0.35; % line width
                    axes(ax1);
                    plot(f1s/1000, gainC(:,L_i), '-', 'LineWidth',lw, 'Color', clr);
                    axes(ax2);
                    plot(f1s/1000, phiC(:, L_i) , '-','LineWidth',lw, 'Color',clr);
                end
            end
            
        case 'd'
            %% Fig. 4D - DPOAE magnitude and phase with f2=21 kHz

            f1s = fig4.d.EC.f1s; % f1 frequency (Hz)
            f2s = fig4.d.EC.f2s; % f2 frequency (Hz)
            fdps = 2*f1s-f2s; % DP frequency (Hz)
            L1s = fig4.d.EC.L1s; % f1 levels (dB SPL)
            L1N = length(L1s);

            magC = fig4.d.EC.mic.dp.magC; % magnitude
            phiC = fig4.d.EC.mic.dp.phiC; % phase
            
            clr = 'r'; % color

            % Set up figure
            h=figure('units','normalized','position',[.4 .2 .18 .42]);            
            ax1 = axes('position',[.18 .42 .7 .3793], 'box', 'off','LineWidth',1.4, 'FontSize',15); hold on;
            ax2 = axes('position',[.18 .16 .7 .24], 'box', 'off','LineWidth', 1.4, 'FontSize', 15); hold on;
            
            axes(ax1); % Amplitude (dB SPL)
            xlim([2.3 21]); set(gca,'Xscale','log','Xtick',[1 2 5 10 20 50],'XMinorTick','off');
            ax1.XAxis.Visible = 'off';
            
            ylim([-15 40]); set(gca,'Ytick',-100:20:100);
            ax1.YAxis.MinorTick = 'on';
            ax1.YAxis.MinorTickValues = -100:10:100;
            ax1.YAxis.TickLength = [0.02 0.02];
            
            axes(ax2); % Phase (cycles)
            xlim([2.3 21]); 
            set(gca,'Xscale','log','Xtick',[1 2 5 10 20 50],'XMinorTick','off');
            ax2.XAxis.TickLength = [0.02 0.02];
            
            ylim([-6 0]); set(gca,'Ytick',-10:2:10);
            ax2.YAxis.MinorTick = 'on';
            ax2.YAxis.MinorTickValues = -10:1:10;
            ax2.YAxis.TickLength = [0.02 0.02];
                        
            % f2/f1 ratio axis
            f2f1ax_pos = ax1.Position;
            f2f1ax_pos(2) = f2f1ax_pos(2) + .02;
            f2f1ax = axes('Position',f2f1ax_pos, 'box','off', 'LineWidth', 1.4, 'FontSize', 12, 'XAxisLocation', 'top','Color', 'none'); hold on;
            f2f1ax.YAxis.Visible = 'off';
            
            xlim([2.3 21]); 
            set(gca,'Xscale','log','TickDir','out','Xtick',[2.333 5.25 9 14 21],'XMinorTick','off','XTickLabels',[])
            f2f1ax.XAxis.MinorTick = 'on';
            f2f1ax.XAxis.MinorTickValues = [2.333 3.7059 5.25 7 9 11.31 17.18 21];
            f2f1ax.XAxis.TickLength = [.015 .015];

            % Plot data for each level
            for L_i=L1N:-1:1
                lw = 0.35+L_i*0.3; % line width
                axes(ax1); % Magnitude (dB SPL)
                plot(fdps/1000, 20*log10(magC(:,L_i)/2e-5), '-', 'LineWidth',lw, 'Color', clr);
                axes(ax2); % Phase (cycles)
                plot(fdps/1000, phiC(:, L_i), '-','LineWidth',lw, 'Color',clr);
            end

        case 'e'
            %% Fig. 4E - Individual BM and DPOAE data for L1=L2=50 dB SPL
            locs = [{'BM'};{'EC'}]; % locations
            locN = length(locs);
            clrs = [{[28 82 172]/255}; {'r'}]; % plot colors
            
            % Set up figure
            h=figure('units','normalized','position',[.58 .2 .14 .2368]);
            ax1 = axes('position',[.18 .15 .7 .75], 'box', 'off','LineWidth',1.4, 'FontSize',15); hold on;
            
            xlim([8 26]); set(gca,'Xscale','log','Xtick',[1 2 5 10 20 50]);
            ax1.XAxis.TickLength = [0.01 0.01];
            
            ylim([-32.5 5]); set(gca,'Ytick',-100:20:100);
            ax1.YAxis.MinorTick = 'on';
            ax1.YAxis.MinorTickValues = -100:10:100;
            ax1.YAxis.TickLength = [0.02 0.02];
             
            % Plot data for each location
            for loc_i = 1:locN
                loc = locs{loc_i}; % location
                clr = clrs{loc_i}; % color

                switch loc
                    case 'BM'
                        f = fig4.e.(genvarname(loc)).f1s; % plot vs. stimulus frequency (Hz)
                        mag = 20*log10(fig4.e.(genvarname(loc)).vib.f1.mag); % displacement magnitude (dB re 1 nm)
                        magC = 20*log10(fig4.e.(genvarname(loc)).vib.f1.magC); % clean displacement magnitude

                    case 'EC'
                        f1s = fig4.e.(genvarname(loc)).f1s; % f1 frequency (Hz)
                        f2s = fig4.e.(genvarname(loc)).f2s; % f2 frequency
                        f = 2*f1s-f2s; % plot vs. DP frequency
                        mag = 20*log10(fig4.e.(genvarname(loc)).mic.dp.mag/2e-5); % DPOAE amplitude (dB SPL)
                        magC = 20*log10(fig4.e.(genvarname(loc)).mic.dp.magC/2e-5); % Clean DPOAE amplitude
                end

                [mag_max,max_i] = max(magC); % find max response

                % Plot normalized and max responses
                plot(f/1000, mag - mag_max, ':','LineWidth',1.8,'Color', clr);
                plot(f/1000, magC - mag_max, '-', 'LineWidth', 3, 'Color', clr);
                plot(f(max_i)/1000, 0, 'o', 'LineWidth', 1.5, 'Color', clr, 'MarkerFaceColor','w','MarkerSize', 8);
            end

        case 'f'
            %% Fig 4F. Q10dB vs stimulus level for individual BM and DPOAE responses
            locs = [{'BM'};{'EC'}]; % locations
            locN = length(locs);
            clrs = [{[28 82 172]/255}; {'r'}]; % plot colors
            mrks = [{'s'}; {'o'}]; % plot symbols

            % Set up figure
            h=figure('units','normalized','position',[.72 .2 .14 .22]);
            ax1 = axes('position',[.15 .15 .75 .75], 'box', 'off', 'LineWidth', 1.4, 'FontSize', 15); hold on;
            
            xlim([37.5 82.5]); set(gca,'Xtick',0:10:100);
            ax1.XAxis.MinorTick = 'off';
            ax1.XAxis.MinorTickValues = 0:5:100;
            ax1.XAxis.TickLength = [.0125 .0125];
            
            ylim([.8 6]); set(gca,'Ytick',0:1:10);
            ax1.YAxis.MinorTick = 'on';
            ax1.YAxis.MinorTickValues = 0:.5:10;
            ax1.YAxis.TickLength = [.0125 .0125];
            
            % Plot data for each location
            for loc_i = 1:locN
                loc = locs{loc_i}; % location
                clr = clrs{loc_i}; % color
                mrk = mrks{loc_i}; % symbol
            
                L1s = fig4.f.(genvarname(loc)).L1s; % stimulus level (dB SPL)

                % Get Q10dB and symbol color
                switch loc
                    case 'BM'
                        mrkClr = clr;
                        q10 = fig4.f.BM.vib.f1.q10;
            
                    case 'EC'
                        mrkClr = 'w';
                        q10 = fig4.f.EC.mic.dp.q10;
                end

                % Plot Q10dB vs. stimulus level
               plot(L1s, q10, '-','Color', clr, 'LineWidth', 2, 'Marker', mrk, 'MarkerFaceColor', mrkClr, 'MarkerSize', 9);
            end

        case 'g'
            %% Fig 4G - Plot ave Q10dB vs stimulus level for BM-OoC and DPOAE responses
            locs = [{'BM'};{'EC'}]; % locations
            locN = length(locs);
            clrs = [{[28 82 172]/255}; {'r'}]; % colors
            mrks = [{'s'}; {'o'}]; % symbols

            % Set up figure
            h=figure('units','normalized','position',[.85 .2 .115 .22]);
            ax1 = axes('position',[.15 .15 .75 .75], 'box', 'off', 'LineWidth', 1.4, 'FontSize', 15); hold on;
            xlim([35 72.5]); set(gca,'Xtick',0:10:100);
            ax1.XAxis.MinorTick = 'off';
            ax1.XAxis.TickLength = [.0125 .0125];
           
            ylim([.8 6]); set(gca,'Ytick',0:1:10);
            ax1.YAxis.MinorTick = 'on';
            ax1.YAxis.MinorTickValues = 0:.5:10;
            ax1.YAxis.TickLength = [.0125 .0125];
            
            % Plot data for each location
            for loc_i = 1:locN
                loc = locs{loc_i}; % location
                clr = clrs{loc_i}; % color
                mrk = mrks{loc_i}; % symbol
            
                % Get stimulus levels, Ave and CI for Q10dB, and marker
                % color
                switch loc
                    case 'BM'
                        mrkClr = clr;
                        L1s = fig4.g.BM.L1s;
                        q10_ave = fig4.g.BM.vib.f1.q10_ave;
                        q10_ci = fig4.g.BM.vib.f1.q10_ci;
                    case 'EC'
                        mrkClr = 'w';
                        L1s = fig4.g.EC.L1s;
                        q10_ave = fig4.g.EC.mic.dp.q10_ave;
                        q10_ci = fig4.g.EC.mic.dp.q10_ci;
                end
                offset = rand(1)-.5;

                % Plot Ave and CI
                errorbar(L1s + offset, q10_ave, q10_ci, '-','Color', clr, 'LineWidth', 2);
                plot(L1s + offset, q10_ave, '-','Color', clr, 'LineWidth', 2,'Marker', mrk, 'MarkerFaceColor', mrkClr, 'MarkerSize', 9);
                
                % Plot individual DPOAE Q10dB for 40 dB SPL stimuli
                if strcmp(loc,'EC')
                    q10_ind = fig4.g.EC.mic.dp.q10_ind(1,:);
                    q10_indN = length(q10_ind);
                    plot(40*ones(1,q10_indN), q10_ind, 'o', 'Color', clr, 'LineWidth', 1.5, 'MarkerFaceColor', 'none', 'MarkerSize', 7);   
                end
            end
        end
end